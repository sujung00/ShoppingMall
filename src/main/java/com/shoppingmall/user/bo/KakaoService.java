package com.shoppingmall.user.bo;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.shoppingmall.user.UserRestController;
import com.shoppingmall.user.model.User;

@Service
public class KakaoService {
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private UserRestController userRestController;

	public String getAccessToken(String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=b71c314d289e413d19ed39d5aad1474e"); // TODO REST_API_KEY 입력
            sb.append("&redirect_uri=http://54.180.124.23:8080/user/kakao"); // TODO 인가코드 받은 redirect_uri 입력
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();

			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);

			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return access_Token;
	}
	
	public Map<String, Object> getUserInfo (String access_Token) {
	    
	    // 요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
	    Map<String, Object> userInfo = new HashMap<>();
	    String reqURL = "https://kapi.kakao.com/v2/user/me";
	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        
	        // 요청에 필요한 Header에 포함될 내용
	        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
	        
	        int responseCode = conn.getResponseCode();
	        System.out.println("responseCode : " + responseCode);
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        
	        String line = "";
	        String result = "";
	        
	        while ((line = br.readLine()) != null) {
	            result += line;
	        }
	        System.out.println("response body : " + result);
	        
	        JsonParser parser = new JsonParser();
	        JsonElement element = parser.parse(result);
	        
	        JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
	        JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
	        
	        String nickname = properties.getAsJsonObject().get("nickname").getAsString();
	        String email = kakao_account.getAsJsonObject().get("email").getAsString();
	        
	        userInfo.put("nickname", nickname);
	        userInfo.put("email", email);
	        
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    
	    return userInfo;
	}
	
	public void kakaoLogin(String nickname, String email, HttpSession session) {
		List<User> userList = userBO.getUserListByEmail(email);
		User kakaoUser = userBO.getUserByLoginIdEmail("kakao@" + nickname, email);
		
		String password = "kakaoPW@" + nickname;
		// user가 존재하지 않는다면 회원 가입 후 로그인
		if(userList == null) {
			// kakao에서 전화번호를 안넘겨주기 때문에 임시로 넣는다.
			userRestController.signUp("kakao@" + nickname, password, nickname, email, "입력 부탁드립니다.", true);
			userRestController.signIn("kakao@" + nickname, password, session);
			// "카카오 계정으로 회원 가입 후 로그인 되었습니다."
		} else if(kakaoUser == null){ // 기존 사이트 회원
			// 존재하지 않는 카카오 계정
			// "이미 존재 하는 이메일 입니다. 일반 계정으로 로그인 부탁 드립니다."
			// 이메일 계정이 같아도 kakaoUser 필드 값이 다르면 회원 가입
			userRestController.signUp("kakao@" + nickname, password, nickname, email, "입력 부탁드립니다.", true);
			userRestController.signIn("kakao@" + nickname, password, session);
		} else { // 카카오 계정으로 로그인 
			userRestController.signIn("kakao@" + nickname, password, session);
			// "카카오 계정으로 로그인 되었습니다."
		}
	}
}

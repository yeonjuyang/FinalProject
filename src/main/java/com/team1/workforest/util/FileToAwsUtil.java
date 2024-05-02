package com.team1.workforest.util;

import java.io.File;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.PutObjectRequest;

import lombok.extern.slf4j.Slf4j;

// 파일을 aws서버에서 
@Slf4j
public class FileToAwsUtil {
	// 파일을 aws서버로 올리기 위한 util
	public static void uploadToS3(File file) {
	    // AWS 자격 증명을 설정
		String accessKeyId = "";
	    String secretAccessKey = "";

	    // S3 클라이언트를 생성
	    AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
	            .withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKeyId, secretAccessKey)))
	            .withRegion("ap-northeast-2") // 예: "us-east-1"
	            .build();

	    // 업로드할 버킷 이름을 설정
	    String bucketName = "projectawsimg";

	    // 파일을 업로드할 S3 경로와 파일 이름을 지정
	    String keyName = "img/" + file.getName(); 

	    try {
	        // S3에 파일을 업로드
	        s3Client.putObject(new PutObjectRequest(bucketName, keyName, file));
	    } catch (AmazonServiceException e) {
	        // 서비스 오류 처리
	        e.printStackTrace();
	    }
	}
	
	public static void deleteFromS3(String fileName) {
		// AWS 자격 증명을 설정
		String accessKeyId = "";
	    String secretAccessKey = "";

	    // S3 클라이언트를 생성
	    AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
	            .withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKeyId, secretAccessKey)))
	            .withRegion("ap-northeast-2") // 예: "us-east-1"
	            .build();

	    // 삭제할 버킷 이름을 설정
	    String bucketName = "projectawsimg";	    
	    String keyName = "img/" + fileName;
	    log.info("delete keyName : {} ", keyName);

	    try {
	    	// S3에서 파일을 삭제
	        s3Client.deleteObject(bucketName, keyName);
	    } catch (AmazonServiceException e) {
	        // 서비스 오류 처리
	        e.printStackTrace();
	    }
	}

}

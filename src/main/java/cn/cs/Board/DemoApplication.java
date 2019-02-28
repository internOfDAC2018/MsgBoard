package cn.cs.Board;


import javax.servlet.MultipartConfigElement;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;

//启动类的注释会加载appilication.yml的数据源
@SpringBootApplication

public class DemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

	@Bean
    public MultipartConfigElement multipartConfigElement() { 
	   MultipartConfigFactory factory = new MultipartConfigFactory();
       //  单个数据大小
       factory.setMaxFileSize("102400KB");
       /// 总上传数据大小
       factory.setMaxRequestSize("102400KB");
       return factory.createMultipartConfig();
    }
}

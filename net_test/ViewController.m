//
//  ViewController.m
//  net_test
//
//  Created by 肖准 on 15/8/10.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *password;


@property(nonatomic,strong)NSMutableData* data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
//    [self login:@"xiaozhun" pass:@"123"];
//    [self startMK];
    //异步get
   // [self startURLget];
    //异步 post
    
 //   [self startURLPost];
   //[self startMK];
  //  [self startMKPost];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)loginPost:(NSString*)user pass:(NSString*)password{
    MKNetworkEngine * engine = [[MKNetworkEngine alloc]initWithHostName:@"127.0.0.1:3000" customHeaderFields:nil];
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setValue:user forKey:@"user"];
    [params setValue:password forKey:@"password"];
    
    MKNetworkOperation * op = [engine operationWithPath:@"/login?" params:params httpMethod:@"POST"];
    NSLog(@"url:%@",[op url]);
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData* data = [completedOperation responseData];
        NSError* err = nil;
        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if(dict&&(err==nil)){
            NSLog(@"success 返回结果:%@",dict);
            
        }else{
            NSLog(@"failed 返回结果：%@",dict);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"error:%@",[error localizedDescription]);
    }];
    
    [engine enqueueOperation:op];
    
}

-(void)loginGet:(NSString*)user pass:(NSString*)password{
    NSString* path = [[NSString alloc]initWithFormat:@"login?user=%@&password=%@",user,password];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc]initWithHostName:@"127.0.0.1:3000" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:nil httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData* data = [completedOperation responseData];
        NSError* err = nil;
        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if(dict&&(err==nil)){
            NSLog(@"success 返回结果:%@",dict);
            
        }else{
            NSLog(@"failed 返回结果：%@",dict);
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"error:%@",[error localizedDescription]);
    }];
    
    [engine enqueueOperation:op];
    
    
    
}

//
//-(void)startMKPost{
//    NSString* path = @"/";
//    MKNetworkEngine * engine =[[MKNetworkEngine alloc]initWithHostName:@"localhost:8080" customHeaderFields:nil];
//    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
//    [params setValue:@"JSON" forKey:@"type"];
//    [params setValue:@"query" forKey:@"action"];
//    
//    
//    
//    
//    MKNetworkOperation* op = [engine operationWithPath:path params:params httpMethod:@"POST"];
//    
//    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:[completedOperation responseData] options:NSJSONReadingAllowFragments error:nil];
//        
//        NSLog(@"dict：%@",dict);
//        
//        
//    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//        NSLog(@"network 错误:%@",[error localizedDescription]);
//        
//    }];
//    [engine enqueueOperation:op];
//    
//    
//    
//}
//
//
//
//-(void)startMK{
//    NSString* path = @"/login?user=tyrant&password=123";
//    
//    MKNetworkEngine * engine = [[MKNetworkEngine alloc]initWithHostName:@"localhost:3000" customHeaderFields:nil];
//    
//    MKNetworkOperation* op = [ engine operationWithPath:path];
//    
//    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//        NSLog(@"response:%@",[completedOperation responseString]);
//        NSData* data = [completedOperation responseData];
//        NSError* er =nil;
//        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
//        if(er){
//            NSLog(@"json 序列化失败");
//            return;
//            
//        }
//        NSLog(@"返回结果：%@",dict);
//        
//        
//    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//        NSLog(@"network 请求错误：%@",[error localizedDescription]);
//        
//    }];
//    [engine enqueueOperation:op];
//    
//}
////syn post
//-(void)startURLPost{
//    NSString * path= [[NSString alloc]initWithFormat:@"http://localhost:3000/login?"];
//    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString* post = [[NSString alloc]initWithFormat:@"user=xiaozhun&password=123"];
//    NSData* postdata=[post dataUsingEncoding:NSUTF8StringEncoding];
//    NSURL* url = [NSURL URLWithString:path];
//    
//    NSMutableURLRequest * re = [[NSMutableURLRequest alloc]initWithURL:url];
//    [re setHTTPMethod:@"POST"];
//    [re setHTTPBody:postdata];
//    
//    NSURLConnection* co = [[NSURLConnection alloc]initWithRequest:re delegate:self];
//    
//    if(co){
//        self.data = [[NSMutableData alloc]init];
//    }
//    
//    
//    
//}
//
////syn get
//-(void)startURLget{
//
//    NSString* path = [[NSString alloc]initWithFormat:@"http://localhost:3000/login?user=xiaozhun&password=123"];
//    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL* url = [NSURL URLWithString:path];
//    NSURLRequest* re = [[NSURLRequest alloc]initWithURL:url];
//    NSURLConnection * co = [[NSURLConnection alloc] initWithRequest:re delegate:self];
//    if(co){
//        
//        self.data = [[NSMutableData alloc]init];
//    }
//    
//    
//}
//
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
//    [self.data appendData:data];
//    
//}
//
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
//    
//    NSLog(@"error:%@",[error localizedDescription]);
//    
//}
//
//-(void )connectionDidFinishLoading:(NSURLConnection *)connection{
//    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingAllowFragments error:nil];
//    
//    NSLog(@"dict:%@",dict);
//    
//    
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

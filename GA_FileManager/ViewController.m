//
//  ViewController.m
//  GA_FileManager
//
//  Created by houjianan on 16/1/30.
//  Copyright © 2016年 houjianan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [self getColor:@"123455"];
    
   //data转image -- image转data
    NSData* imageData;
    UIImage* image = [UIImage imageWithData:imageData];
//    imageData = UIImagePNGRepresentation(image);
    imageData = UIImageJPEGRepresentation(image, 1);
    
    
    //字符串转data
    NSString* myString = @"GA是炼金术师";
    NSData* str_data = [myString dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@--%@",str_data, str_data.class);
    //data转字符串
    NSString* ss = [[NSString alloc] initWithData:str_data encoding:NSUTF8StringEncoding];
    NSLog(@"%@--%@",ss, ss.class);
    
    //NSData->char*
    char *test = [str_data bytes];
    NSLog(@"--%s--",test);
    //char*->NSData
    Byte *byte[4];
    byte[0] = 0x30;
    byte[1] = 0x31;
    byte[2] = 0x32;
    byte[3] = 0x33;
    NSData *data = [NSData dataWithBytes:byte length:4];
    NSLog(@"%@--%@",data, data.class);
    
    //字符串数字转成整型，字符串
    NSString* intString = @"13我14";
    int intString_int = [intString intValue];
    float intString_float = [intString floatValue];
    NSLog(@"%d, %f", intString_int, intString_float);
    
    NSString *int_intString = [NSString stringWithFormat:@"%d%f",intString_int,intString_float];
    NSLog(@"%@--%@",int_intString, int_intString.class);
    
    NSDictionary* dic = @{@"name" : @"JiaNan", @"age" : @18};
    //字典转data
    NSData* dic_data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSLog(@"%@--%@",dic_data, dic_data.class);
    //data转字典
    NSDictionary* data_dic = [NSJSONSerialization JSONObjectWithData:dic_data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@--%@",data_dic, data_dic.class);
    //字典转字符串 = =！
    NSString* str = [NSString stringWithFormat:@"%@", dic];
    NSLog(@"%@--%@",str, str.class);
    //字典结构的字符串转字典
    NSString* strDic = @"{\"status\":\"1\",\"url\":\"http://www.baidu.com\"}";
    NSData* str_data1 = [strDic dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* data_dic1 = [NSJSONSerialization JSONObjectWithData:str_data1 options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@--%@",data_dic1, data_dic1.class);
    
    //时间转字符串
    NSDate* date = [NSDate date];
    NSLog(@"%@--%@", date, date.class);
    NSString* date_str1 = [date description];
    NSLog(@"%@--%@",date_str1, date_str1.class);
    //时间转成NSTimeInterval字符串
    NSString* date_timeIntervalString = [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    NSLog(@"%@--%@",date_timeIntervalString, date_timeIntervalString.class);
    //NSTimeInterval字符串转成时间
    NSDate *str_date = [NSDate dateWithTimeIntervalSince1970:[date_timeIntervalString intValue]];
    NSLog(@"%@--%@",str_date, str_date.class);
    //将时间戳转换成NSDate,加上时区偏移。转成（北京时间）
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:str_date];
    NSDate *localeDate = [str_date dateByAddingTimeInterval: interval];
    NSLog(@"%@--%@",localeDate, localeDate.class);
    //时间差
    NSDate *date1970 = [NSDate dateWithTimeIntervalSince1970:0];
    NSLog(@"%@--%@",date1970, date1970.class);
    long difference = fabs([localeDate timeIntervalSinceDate:date1970]);
    NSLog(@"%ld",difference);
    //将时间转成指定格式
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH-mm-ss"];
    NSString* string = [dateFormat stringFromDate: date1970];
    NSLog(@"%@--%@",string, string.class);
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH-mm-ss"];//这个格式要和string格式一致
    NSDate *fromdate = [formatter dateFromString:string];
    NSLog(@"%@--%@",fromdate, fromdate.class);
    
    //当前时间转成年月日
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];
    NSInteger sec = [comps second];
    
    NSString *ymdhms = [NSString stringWithFormat:@"%ld年%ld月%ld日%ld时%ld分%ld秒",(long)year,(long)month,(long)day,(long)hour,(long)min,(long)sec];
    NSLog(@"%@--%@",ymdhms, ymdhms.class);
}
//使用内联函数十六进制转UIColor
- (UIColor *) stringTOColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}
//十六进制转UIColor
- (UIColor *)getColor:(NSString*)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
}

//发送数据时,16进制数－>Byte数组->NSData,加上校验码部分
-(NSData *)hexToByteToNSData:(NSString *)str
{
    int j=0;
    Byte bytes[[str length]/2];                         ////Byte数组即字节数组,类似于C语言的char[],每个汉字占两个字节，每个数字或者标点、字母占一个字节
    for(int i=0;i<[str length];i++)
    {
        /**
         *  在iphone/mac开发中，unichar是两字节长的char，代表unicode的一个字符。
         *  两个单引号只能用于char。可以采用直接写文字编码的方式来初始化。采用下面方法可以解决多字符问题
         */
        int int_ch;                                     ///两位16进制数转化后的10进制数
        unichar hex_char1 = [str characterAtIndex:i];   ////两位16进制数中的第一位(高位*16)
        
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
        {
            int_ch1 = (hex_char1-48)*16;                //// 0 的Ascll - 48
        }
        else if(hex_char1 >= 'A' && hex_char1 <='F')
        {
            int_ch1 = (hex_char1-55)*16;                //// A 的Ascll - 65
        }
        else
        {
            int_ch1 = (hex_char1-87)*16;                //// a 的Ascll - 97
        }
        
        i++;
        
        unichar hex_char2 = [str characterAtIndex:i];   ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
        {
            int_ch2 = (hex_char2-48);                   //// 0 的Ascll - 48
        }
        else if(hex_char2 >= 'A' && hex_char2 <='F')
        {
            int_ch2 = hex_char2-55;                     //// A 的Ascll - 65
        }
        else
        {
            int_ch2 = hex_char2-87;                     //// a 的Ascll - 97
        }
        
        int_ch = int_ch1+int_ch2;
        bytes[j] = int_ch;                              ///将转化后的数放入Byte数组里
        
        //        if (j==[str length]/2-2) {
        //            int k=2;
        //            int_ch=bytes[0]^bytes[1];
        //            while (k
        //                int_ch=int_ch^bytes[k];
        //                k++;
        //            }
        //            bytes[j] = int_ch;
        //        }
        
        j++;
    }
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:[str length]/2 ];
    NSLog(@"%@",newData);
    return newData;
}
//接收数据时,NSData－>Byte数组->16进制数
-(NSString *)NSDataToByteTohex:(NSData *)data
{
    Byte *bytes = (Byte *)[data bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数,与 0xff 做 & 运算会将 byte 值变成 int 类型的值，也将 -128～0 间的负值都转成正值了。
        if([newHexStr length]==1)
        {
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else
        {
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    NSLog(@"hexStr:%@",hexStr);
    return hexStr;
}
//将汉字字符串转换成16进制字符串
-(NSString *)chineseToHex:(NSString*)chineseStr
{
    NSStringEncoding encodingGB18030= CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *responseData =[chineseStr dataUsingEncoding:encodingGB18030 ];
    NSString *string=[self NSDataToByteTohex:responseData];
    NSLog(@"%@",string);
    return string;
}
//将汉字字符串转换成UTF8字符串
-(NSString *)chineseToUTf8Str:(NSString*)chineseStr
{
    NSStringEncoding encodingUTF8 = NSUTF8StringEncoding;
    NSData *responseData2 =[chineseStr dataUsingEncoding:encodingUTF8 ];
    NSString *string=[self NSDataToByteTohex:responseData2];
    return string;
}
//将十六进制字符串转换成汉字
-(NSString*)changeLanguage:(NSString*)chinese
{
    NSString *strResult;
    NSLog(@"chinese:%@",chinese);
    if (chinese.length%2==0)
    {
        //第二次转换
        NSData *newData = [self hexToByteToNSData:chinese];
        unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        strResult = [[NSString alloc] initWithData:newData encoding:encode];
        NSLog(@"strResult:%@",strResult);
    }
    else
    {
        NSString *strResult = @"已假定是汉字的转换，所传字符串的长度必须是4的倍数!";
        NSLog(@"%@",strResult);
        return NULL;
    }
    return strResult;
}
/////////////GBK,汉字，GB2312,ASCII码，UTF8,UTF16
//UTF8字符串转换成汉字
-(NSString*)changeLanguageUTF8:(NSString*)chinese
{
    NSString *strResult;
    NSData *data=[self hexToByteToNSData:chinese];
    strResult=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return strResult;
}
//将十进制数转换成十六进制
-(NSString *)ToHex:(int)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++)
    {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0)
        {
            break;
        }
        
    }
    return str;
}




//Unicode转化为汉字
- (NSString *)replaceUnicode1:(NSString *)unicodeStr
{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    NSLog(@"%@",[returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"]);
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

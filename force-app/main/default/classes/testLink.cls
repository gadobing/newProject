public class testLink {
@AuraEnabled
    public static String getLabel(){
        String url = 'hello';
        System.debug('label ' + url);
        return url;
    }
}
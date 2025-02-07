public with sharing class CourseDeliveryTriggerHandler {
    private static Set<Date> allHolidays = new Set<Date>();

    static {
        for (Holiday h : [SELECT ActivityDate FROM Holiday]) {
            allHolidays.add(h.ActivityDate);
        }
    }

    public static void preventInvalidCourseDeliveries(List<Course_Delivery__c> newCourseDeliveryList,
                                                      Map<ID, Course_Delivery__c> oldCourseDeliveryMap) {
        
        for (Course_Delivery__c cd : newCourseDeliveryList) {
            if (oldCourseDeliveryMap?.get(cd.Id).Start_Date__c != cd.Start_Date__c) {   
                if ( allHolidays.contains(cd.Start_Date__c) ) {
                    cd.Start_Date__c.addError('Course Delivery cannot be scheduled because it starts on a holiday.');
                    
                    // TODO #1
                    // Immediately Publish a platform event with details of the error

                }
            }
        }
    }
}
public class CaseAssignment {
    private static Map<Id, Integer> lastIndexMap = new Map<Id, Integer>();

    public static Id getNextUser(List<User> users, Id ownerId) {
        if (users.isEmpty()) {
            return null;
        }

        Integer lastIndex = lastIndexMap.get(ownerId);
        if (lastIndex == null) {
            lastIndex = 0;
        }

        Integer nextIndex = Math.mod(lastIndex + 1, users.size());
        lastIndexMap.put(ownerId, nextIndex);

        return users[nextIndex].Id;
    }
    
   public static Map<Id, List<User>> getUsersByOwnerIds(List<Id> ownerIds) {
        Map<Id, List<User>> usersMap = new Map<Id, List<User>>();
        for (User user : [SELECT Id, Name, UserRole.Name FROM User WHERE UserRole.Id IN :ownerIds]) {
            if (!usersMap.containsKey(user.UserRoleId)) {
                usersMap.put(user.UserRoleId, new List<User>());
            }
            usersMap.get(user.UserRoleId).add(user);
        }
        return usersMap;
    }
    
 
}

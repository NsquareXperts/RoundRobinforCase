public class CaseAssignment {
    // Map to store the last assigned user index for each round-robin group
    private static Map<Id, Integer> lastAssignedUserIndexMap = new Map<Id, Integer>();

    public static void assignCases(List<Case> cases) {
        // Retrieve eligible users for case assignment (e.g., based on roles)
        List<User> users = getUsersForAssignment();

        if (users.isEmpty()) {
            // No eligible users found
            return;
        }

        // Initialize the last assigned user index if not already initialized
        for (User user : users) {
            if (!lastAssignedUserIndexMap.containsKey(user.Id)) {
                lastAssignedUserIndexMap.put(user.Id, 0);
            }
        }

        // Assign cases in round-robin fashion
        for (Case newCase : cases) {
            // Get the last assigned user index for the round-robin group
            Integer lastIndex = lastAssignedUserIndexMap.get(users[0].Id);

            // Get the next user to assign the case to using round-robin logic
            User nextUser = users[(lastIndex + 1) % users.size()];

            // Assign the case to the next user in the round-robin sequence
            newCase.OwnerId = nextUser.Id;

            // Update the last assigned user index for the round-robin group
            lastAssignedUserIndexMap.put(users[0].Id, (lastIndex + 1) % users.size());
        }
    }

    private static List<User> getUsersForAssignment() {
        // Query and return the list of eligible users (e.g., based on roles)
        return [SELECT Id FROM User WHERE UserRole.Name = 'Your Role Name'];
    }
}

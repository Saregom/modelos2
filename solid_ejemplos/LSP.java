package solid_ejemplos;


interface MessageService {
    void sendMessage(String message);
}

class EmailService implements MessageService {
    public void sendMessage(String message) {
        System.out.println("Enviando correo: " + message);
    }
}

class UserNotification {
    private MessageService messageService;

    public UserNotification(MessageService messageService) {
        this.messageService = messageService;
    }

    public void notifyUser(String message) {
        messageService.sendMessage(message);
    }
}

public class LSP {
    public static void main(String[] args) {
        MessageService emailService = new EmailService();
        
        UserNotification userNotification = new UserNotification(emailService);
        
        userNotification.notifyUser("Hola profe, pongame un 5.0!");
    }
}
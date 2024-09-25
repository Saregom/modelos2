package solid_ejemplos;

// Interface
interface MessageService {
    void sendMessage(String message);
}

// Implementación del servicio de correo electrónico
class EmailService implements MessageService {
    public void sendMessage(String message) {
        System.out.println("Enviando correo: " + message);
    }
}

// Clase de notificación que depende de la abstracción (interface)
class UserNotification {
    private MessageService messageService;

    // Inyección de dependencia a través del constructor
    public UserNotification(MessageService messageService) {
        this.messageService = messageService;
    }

    public void notifyUser(String message) {
        messageService.sendMessage(message);
    }
}

// Main
public class LSP {
    public static void main(String[] args) {
        // instancia del servicio de mensajería
        MessageService emailService = new EmailService();
        
        // instancia de UserNotification pasando el servicio
        UserNotification userNotification = new UserNotification(emailService);
        
        // Notificar al usuario
        userNotification.notifyUser("Hola profe, pongame un 5.0!");
    }
}
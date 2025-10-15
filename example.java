@Component(
    modules = {
      // keep-sorted start
      AuthModule.class,
      GetRequestModule.class,
      LoggingModule.class,
      MonitoringModule.class,
      PostRequestModule.class,
      UtilsModule.class,
      // keep-sorted end
    })
interface FrontendComponent {
  FrontendRequestHandler requestHandler();
}

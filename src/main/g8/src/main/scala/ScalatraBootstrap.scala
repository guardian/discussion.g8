import javax.servlet.ServletContext

import $organisation$.$name;format="Camel"$Servlet
import org.scalatra._

class ScalatraBootstrap extends LifeCycle {
  override def init(context: ServletContext) {
    context.mount(new $name;format="Camel"$Servlet, "/*")
  }
}

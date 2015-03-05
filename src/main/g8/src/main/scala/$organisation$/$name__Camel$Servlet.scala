package $organisation$

import org.json4s.{DefaultFormats, Formats}
import org.scalatra.json._
import org.scalatra.{NotImplemented, Ok, ScalatraServlet}

class $name;format="Camel"$Servlet extends ScalatraServlet with JacksonJsonSupport {

  protected implicit val jsonFormats: Formats = DefaultFormats

  before() {
    contentType = formats("json")
  }

  get("/service/healthcheck") {
    Ok(ServiceOk("OK"))
  }

  get("/service/gtg") {
    NotImplemented(ServiceNotOk("Endpoint needs to be specified"))
  }

  get("/service/dependencies") {
    NotImplemented(ServiceNotOk("Endpoint needs to be specified"))
  }
}

sealed trait ServiceResponse
case class ServiceOk(message: String) extends ServiceResponse
case class ServiceNotOk(message: String) extends ServiceResponse
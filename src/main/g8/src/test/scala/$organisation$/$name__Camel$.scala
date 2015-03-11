package $organisation$

import org.scalatest.FunSuiteLike
import org.scalatra.test.scalatest.ScalatraSuite

class $name;format="Camel"$ServletTests extends ScalatraSuite with FunSuiteLike {

  addServlet(classOf[$name;format="Camel"$Servlet], "/*")

  test("simple get") {
    get("/management/healthcheck") {
      status should equal (200)
      body should include ("OK")
    }
  }

}

package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ConnectionDB;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ")
				.append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		System.out.println("LoginServlet: do post loginservlet");

		HttpSession currentSession = request.getSession();
		if (currentSession.getAttribute("remember_me") != null)
			response.sendRedirect("search.jsp");
		else {
			String login = (String) request.getParameter("login");
			String pass = (String) request.getParameter("password");
			String remember_me = (String) request.getParameter("remember_me");
			System.out.println(
					"LoginServlet: login = " + login + " password =" + pass);

			if (hasPermissions(login, pass)) {
				System.out.println(
						"LoginServlet: You have permissions for search page!");
				currentSession.setAttribute("login", login);
				if (remember_me != null && remember_me.equals("on"))
					currentSession.setAttribute("remember_me", "on");
				response.sendRedirect("search.jsp");
			} else {
				System.out.println(
						"LoginServlet: You have not permissions search page!");
				response.sendRedirect("login.jsp");
			}
		}
	}

	public static boolean hasPermissions(String login, String pass) {
		boolean result = false;
		if (login == null || pass == null || login.isEmpty()
				|| pass.isEmpty()) {
			return false;
		}

		Connection connection = ConnectionDB.getConnection();
		if (connection != null) {
			System.out.println(
					"LoginServlet: You made it, take control your database now!");
		} else {
			System.out.println("LoginServlet: Failed to make connection!");
			return false;
		}

		String sql = ConnectionDB.getLoginSql(login, pass);
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				result = true;
				break;
			}
			rs.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out
					.println("LoginServlet: problems with executing query...");
		}

		return result;
	}

}

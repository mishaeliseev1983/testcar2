package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ConnectionDB;
import model.DataOwner;

/**
 * Servlet implementation class SearchServlet
 */
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public SearchServlet() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		System.out.println("do get !");
		response.setContentType("text/html;charset=utf-8");

		HttpSession currentSession = request.getSession();

		if (currentSession.getAttribute("login") != null) {
			System.out.println("current user = "
					+ currentSession.getAttribute("login").toString());
		}

		System.out.println("-------- PostgreSQL JDBC Connection------------");

		Connection connection = ConnectionDB.getConnection();
		if (connection != null) {
			System.out.println(
					"SearchServlet: You made it, take control your database now!");
		} else {
			System.out.println("SearchServlet: Failed to make connection!");
			return;
		}

		System.out.println("SearchServlet: dataquery = "
				+ request.getParameter("dataquery"));

		String dataquery = request.getParameter("dataquery");
		String[] dataqueryArray = dataquery.split(":");
		String name = getValueFromArray(dataqueryArray, 0);
		String surname = getValueFromArray(dataqueryArray, 1);
		String patronymic = getValueFromArray(dataqueryArray, 2);
		String city = getValueFromArray(dataqueryArray, 3);
		String model = getValueFromArray(dataqueryArray, 4);

		System.out.println("name = " + name + " | surname = " + surname
				+ " | patronymic = " + patronymic + " | city = " + city
				+ " | model = " + model);

		PrintWriter out = response.getWriter();
		String sql = ConnectionDB.getSearchSql(name, surname, patronymic, city,
				model);
		PreparedStatement ps = null;
		List<DataOwner> list = new ArrayList<DataOwner>();
		try {
			ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				String oname = rs.getString("oname");
				String osurname = rs.getString("osurname");
				String opatronymic = rs.getString("opatronymic");
				String camodel = rs.getString("camodel");
				String canumber = rs.getString("canumber");
				String ciname = rs.getString("ciname");

				System.out.println(" oname = " + oname + "| osurname = "
						+ osurname + " | opatronymic= " + opatronymic
						+ " | camodel = " + camodel + " | canumber = "
						+ canumber + " | ciname = " + ciname);
				DataOwner data = new DataOwner();
				data.setName(oname);
				data.setSurname(osurname);
				data.setCity(ciname);
				data.setPatronymic(opatronymic);
				data.setCarModel(camodel);
				data.setCarNumber(canumber);
				list.add(data);
			}
			rs.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out
					.println("SearchServlet: problems with executing query...");
		}
		System.out.println(
				"SearchServlet: start preparing response with data...");
		String res = "";
		for (int i = 0; i < list.size(); i++) {
			DataOwner d = list.get(i);
			String val = d.getName() + ":" + d.getSurname() + ":"
					+ d.getPatronymic() + ":" + d.getCity() + ":"
					+ d.getCarNumber() + ":" + d.getCarModel();
			if (i == list.size() - 1)
				res += val;
			else
				res += val + "_next_Object_";

		}
		System.out
				.println("SearchServlet: prepared response with data = " + res);
		out.print(res);
		out.close();
	}

	private String getValueFromArray(String[] dataqueryArray, int i) {
		if (dataqueryArray.length > i && dataqueryArray[i] != null)
			return dataqueryArray[i];
		return "";
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/*
 * For db's queries
 */
public class ConnectionDB {
	public static String dburl = "jdbc:postgresql://localhost:5432/carowner";
	public static String user = "test_user_postrgres";
	public static String pwd = "test_user_postrgres";

	public static Connection getConnection() {
		Connection connection = null;

		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {

			System.out.println("PostgreSQL JDBC Driver was not found ");
			e.printStackTrace();
			return connection;
		}

		try {
			connection = DriverManager.getConnection(dburl, user, pwd);
		} catch (SQLException e) {

			System.out.println("Connection Failed! Check output console");
			e.printStackTrace();
			return connection;
		}
		return connection;
	}

	public static String getSearchSql(String n, String s, String p, String c,
			String m) {
		String sql = "select o.id, o.name as oname, o.surname as osurname, o.patronymic as opatronymic,  "
				+ "ci.name as ciname, ca.model as camodel , ca.number as canumber  "
				+ "  from owner o, city ci, car ca  "
				+ "where upper(ci.name) like " + getQueryValue(c)
				+ " and ci.id=o.id_city and "
				+ "o.id=ca.id_owner and upper(ca.model) like "
				+ getQueryValue(m) + " and upper(o.name) like "
				+ getQueryValue(n) + " and upper(o.surname) like  "
				+ getQueryValue(s) + " and upper(o.patronymic) like  "
				+ getQueryValue(p);

		System.out.println(" sql = " + sql);
		return sql;
	}

	public static String getLoginSql(String login, String password) {
		String sql = "select id from users where username = '" + login
				+ "' and password = '" + password + "'";
		return sql;
	}

	private static String getQueryValue(String val) {
		String all = "'%%'";
		if (val == null || val.isEmpty())
			val = all;
		else
			val = "upper('%" + val + "%')";
		return val;
	}

}

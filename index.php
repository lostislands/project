<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta charset="utf-8" />
	<meta name="author" content="Eric Greger" />
	<meta name="keywords" content="Piraten, Händler, Marine, Schiffe, Meer, Krieg, Handel, Browsergame, MMO" />
    <meta name="description" content="Piraten, Marine und Händler im Kampf um die Vorherschaft auf See!" />
    <link rel="stylesheet" type="text/css" href="styles/index.css" />
    <title>Lostislands - Das Browsergame</title>
</head>
<body>
	<div class="container">
		<!-- Header -->
		<header>
			<img src="images/index_header.jpg" title="Lostislands - Werde zum König der Meere!" alt="" height="100" width="800" />
		</header>
		<!-- Content -->
		<div class="content">
			<!-- Registrierung -->
		    <!-- TODO: action zuweisung -->
			<form class="registry paper" name="reg_form" method="post">
                <h1>Registrierung</h1>
				<p>
                    <label for="reg_username">Username:</label>
                    <input type="text" name="reg_username" id="reg_username" pattern="^[A-Za-z_-]{3,15}$" title="3-15 Zeichen, keine Sonderzeichen" maxlength="15" required="required" />
				</p>
                <p>
                    <label for="reg_faction">Fraktion:</label>
                    <select name="reg_faction" id="reg_faction">
                        <option>-- auswählen --</option>
                        <option value="1">Piraten</option>
                        <option value="2">Händler</option>
                        <option value="3">Marine</option>
                    </select>
                </p>
                <p>
                    <label for="reg_password">Passwort:</label>
                    <input type="password" name="reg_password" id="reg_password" maxlength="20" required="required" />
				</p>
                <p>
                    <label for="reg_password_val">Passwort wiederholen:</label>
					<input class="middle" type="password" name="reg_password_val" id="reg_password_val" maxlength="20" required="required" />
				</p>
                <p>
                    <label for="reg_email">Email:</label>
					<input type="email" name="reg_email" id="reg_email" required="requiered" />
				</p>
                <p>
                    <label for="reg_agb">AGBs</label>
					<input type="checkbox" name="reg_agb" id="reg_agb" required="required" />
                </p>
				<p>
                	<label for="reg_newsletter">Newsletter</label>
                    <input type="checkbox" name="reg_newsletter" id="reg_newsletter" />
                </p>
				<p>
                    <input type="submit" value="Registrieren" />
                </p>
			</form>
			<!-- Login -->
			<!-- TODO: action zuweisung -->
			<form class="login paper" name="login<_form" method="post">
                <h1>Login</h1>
				<p>
                    <label for="login_username">Username:</label>
    				<input type="text" name="log_username" id="log_username" maxlength="15" autofocus="autofocus" required="required" />
				</p>
                <p>
                    <label for="login_password">Passwort:</label>
    				<input type="password" name="log_password" id="log_password" maxlength="20" required="required" />
				</p>
                <p>
                    <input type="submit" value="Login" />
                </p>
            </form>
		</div>
        
		<!-- Footer -->
		<footer>
            <p class="version">Version:0.0.1</p>
            <ul class="links">
                <li><a href="konfig.php">Forum</a></li>
                <li><a href="changelog.html">Changelog</a></li>
                <li><a href="agbs.html">AGBs</a></li>
                <li><a href="impressum.html">Impressum</a></li>
            </ul>
		</footer>
	</div>
</body>
</html>
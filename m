From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 13:42:42 +0200
Subject: [RFC] arm: Add for atomic half word exchange
In-Reply-To: <1795987946.405311432034410830.JavaMail.weblogic@ep2mlwas07a>
References: <1795987946.405311432034410830.JavaMail.weblogic@ep2mlwas07a>
Message-ID: <39330782.97MFhnlPJe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 May 2015 11:20:11 Sarbojit Ganguly wrote:
> Yes, I will try to do that. OTOH, I saw that  there was a discussion on
> removal of bad_xchg() altogether. Perhaps that approach be better than
> adding this half word exchange?

Removing bad_xchg() only helps insofar as we get a link-time error
instead of a run-time error. That is certainly a good idea, but it
does not solve your problem.

	Arnd

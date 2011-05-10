From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 10 May 2011 14:32:43 +0100
Subject: [PATCH v4 08/11] tty: add pruss SUART driver
In-Reply-To: <F0818DA1343E4FF1B3096048359CCC4C@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-9-git-send-email-subhasish@mistralsolutions.com>
	<034A6447E0D54737B5CEE009A4D20B37@subhasishg>
	<20110509144610.6b4f7090@lxorguk.ukuu.org.uk>
	<3A9C5CD56396439DBF825BB4E5779DB9@subhasishg>
	<20110509145534.2677dfa1@lxorguk.ukuu.org.uk>
	<F0818DA1343E4FF1B3096048359CCC4C@subhasishg>
Message-ID: <20110510143243.3e6f4050@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trace all looks fine. I can't see anything else taking the lock so you'll
need to do a bit more debugging and find out why the spin lock change
makes the difference and what the real root cause is.

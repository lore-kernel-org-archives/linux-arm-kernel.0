From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 May 2011 09:47:49 +0200
Subject: [PATCH 02/10] mach-u300: rewrite gpio driver, move to drivers/gpio
In-Reply-To: <20110520070127.GD21285@ponder.secretlab.ca>
References: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
	<20110519085638.GA26816@S2100-06.ap.freescale.net>
	<BANLkTinD9rAipfwNnh6QpgbcogckdtQ=OQ@mail.gmail.com>
	<20110519135631.GB26816@S2100-06.ap.freescale.net>
	<20110519191156.GE2429@pengutronix.de>
	<20110520070127.GD21285@ponder.secretlab.ca>
Message-ID: <BANLkTikbh274uE983V=dPiiN27DoafgtTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/20 Grant Likely <grant.likely@secretlab.ca>:

> That said, I don't mind moving stuff into drivers/gpio first and
> consolidating it after.

Speaking of which, the topic of the post is not going to be merged
since I did too much in this patch trying to solve all issues at once.

I'll post something much simpler that just moves the U300 and
Nomadik gpio over.

Linus Walleij

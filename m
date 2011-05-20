From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 19 May 2011 23:54:12 -0400 (EDT)
Subject: [PATCH 02/10] mach-u300: rewrite gpio driver, move to drivers/gpio
In-Reply-To: <BANLkTikonewi-fxCxoxx=ARsTs-CPvfoTg@mail.gmail.com>
References: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
	<20110519085638.GA26816@S2100-06.ap.freescale.net>
	<BANLkTinD9rAipfwNnh6QpgbcogckdtQ=OQ@mail.gmail.com>
	<20110519135631.GB26816@S2100-06.ap.freescale.net>
	<20110519191156.GE2429@pengutronix.de>
	<alpine.LFD.2.00.1105191527440.14430@xanadu.home>
	<20110520031818.GB27251@S2100-06.ap.freescale.net>
	<BANLkTikonewi-fxCxoxx=ARsTs-CPvfoTg@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1105192351360.14430@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 May 2011, Kyungmin Park wrote:

> BTW, how do you think the GPIO interrupt routine. If it uses the
> drivers/gpio drivers, it also cover the gpio interrupt codes at
> drivers/gpio? or separate it?

Let's just do the move for now.  I don't think it is worth splitting out 
the IRQ code just yet, unless there is a common pattern to be seen 
there.


Nicolas

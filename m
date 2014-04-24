From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 24 Apr 2014 16:03:38 +0200
Subject: socfpga in 3.15-rc2
In-Reply-To: <20140424125421.GA19526@amd.pavel.ucw.cz>
References: <20140424125421.GA19526@amd.pavel.ucw.cz>
Message-ID: <734n1i25ad.fsf@unicorn.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi!

Pavel Machek <pavel@ucw.cz> writes:
> Hi!
>
> Does socfpga boot for you on 3.15-rc2? Mainline worked on 3.14 pretty
> well, but I get no output from serial from 3.15-rc2. Any ideas?
>

You need:

[PATCH] clk: socfpga: fix clock driver for 3.15
Message-Id: 1397481336-5592-1-git-send-email-dinguyen at altera.com

Regards,
Steffen

-- 
Pengutronix e.K.                           | Steffen Trumtrar            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

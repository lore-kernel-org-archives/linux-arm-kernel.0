From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 3 Sep 2010 14:03:10 +0200
Subject: imx.c : dte mode and modem control
In-Reply-To: <AANLkTi=jrVQAnzr6PAMU_Ycenhjp7_Aww-x=769VdOEN@mail.gmail.com>
References: <AANLkTi=jrVQAnzr6PAMU_Ycenhjp7_Aww-x=769VdOEN@mail.gmail.com>
Message-ID: <20100903120310.GA4813@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I use i.MX25 uart to communicate with a modem (PSTN or GSM/GPRS). The
> DCD, DTR and RI signals are used. On our board, these signals are used
> on iMX25 with DTE mode (i.MX25 DTR is an output). imx.c does not
> support modem signals and DTE mode. These features existed in the file
> mxc_uart.c who was present in the freescale bsp until 2.6.28. Is it
> planned to integrate these features into imx.c ?

I haven't heard such plans...

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100903/6b8d071c/attachment.sig>

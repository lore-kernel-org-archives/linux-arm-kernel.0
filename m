From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 1 Jul 2011 08:03:56 +0200
Subject: [PATCH v5 1/3] ARM: mxs: add GPMI-NFC support for imx23/imx28
In-Reply-To: <201107010022.26597.arnd@arndb.de>
References: <1309406028-2924-1-git-send-email-b32955@freescale.com>
	<201106301555.19440.arnd@arndb.de>
	<19980.36638.134045.743619@ipc1.ka-ro>
	<201107010022.26597.arnd@arndb.de>
Message-ID: <20110701060356.GA27039@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> If you really want to call out obsceneties, how about the fact that this
> driver comes with an 805 line patch to add a HAL for a single chip!
> 
> Such abstractions should not be introduced as long as there is only
> a single instance of the hardware.

If I understood correctly, most if not all upcoming i.MX will have the GPMI
(mx50, mx6). Huang, do you already have a draft for the mx50-hal?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110701/e03d6241/attachment.sig>

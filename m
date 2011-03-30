From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 30 Mar 2011 11:16:20 +0200
Subject: [PATCH v2 1/1] ARM: imx: add gpu device
In-Reply-To: <20110330091210.GA19394@pengutronix.de>
References: <1301465128-401-1-git-send-email-richard.zhao@freescale.com>
	<20110330071658.GQ30938@pengutronix.de>
	<20110330081625.GB3195@b20223-02.ap.freescale.net>
	<AANLkTimGUvNra0igyUGRJrzj5y3SwYFt4WEGKrLxd88-@mail.gmail.com>
	<20110330091210.GA19394@pengutronix.de>
Message-ID: <20110330091620.GD2232@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Difference between steppings is a bit tricky though, I think a QUIRK_
> > way, and pass combined QUIRK_* flags will be better in imx35_add_mxc_gpu()
> > function itself.
> ... or that

No driver, no problem?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110330/640ba646/attachment-0001.sig>

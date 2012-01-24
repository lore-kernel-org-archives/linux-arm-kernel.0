From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 24 Jan 2012 22:09:24 +0100
Subject: LPC32xx status (Re: [PATCH] Correct bad gpio naming)
In-Reply-To: <4F1F16A8.7010407@antcom.de>
References: <4F1C4E25.6070801@antcom.de> <20120124155921.GH2609@pengutronix.de>
 <4F1EDD15.7010704@antcom.de> <20120124192545.GB8502@pengutronix.de>
 <4F1F16A8.7010407@antcom.de>
Message-ID: <20120124210924.GD8502@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Unfortunately, I currently don't have a phy3250, but can check
> tomorrow with colleagues.

Shouldn't matter that much, or? Once the core support is back and works for
your board, others could test with their boards.

> I guess the work92105_defconfig is only useful once the drivers
> currently missing in mainline are merged. Or is there an arm specific
> tree I should update from?

You can keep the work92105_defconfig in your tree, but we'd need to introduce a
lpc32xx_defconfig. That should start with a minimal (but working) config and
can be extended once the drivers are in place.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120124/17c3e0f3/attachment.sig>

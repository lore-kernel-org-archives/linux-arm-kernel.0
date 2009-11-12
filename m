From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 12 Nov 2009 14:06:57 +0100
Subject: [PATCH 5/9] pcm043: Add NAND support
In-Reply-To: <22546.72684.qm@web51004.mail.re2.yahoo.com>
References: <1258022525-21078-6-git-send-email-s.hauer@pengutronix.de>
	<22546.72684.qm@web51004.mail.re2.yahoo.com>
Message-ID: <20091112130657.GZ30179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Thu, Nov 12, 2009 at 04:43:59AM -0800, Fabio Estevam wrote:
> 
> Have you managed to load a root file system via JFFS2 on this board?

No, I'm using UBIFS. There still is a bug with oob handling preventing
jffs2 to work properly on i.MX35 (see my mail on the mtd list). I have a
fix for this and I assume I could boot from JFFS2 now, but I haven't
tested.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

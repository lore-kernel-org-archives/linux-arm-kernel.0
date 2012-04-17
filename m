From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 17 Apr 2012 19:48:24 +0200
Subject: [PATCH] i.MX28: Shut down the LCD controller to avoid bootrom
 sampling bug
In-Reply-To: <1334675261-31570-1-git-send-email-marex@denx.de>
References: <1334675261-31570-1-git-send-email-marex@denx.de>
Message-ID: <20120417174824.GD22406@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 05:07:41PM +0200, Marek Vasut wrote:
> From: Marek Vasut <marek.vasut@gmail.com>
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> Cc: Chen Peter-B29397 <B29397@freescale.com>
> Cc: Detlev Zundel <dzu@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Li Frank-B20596 <B20596@freescale.com>
> Cc: Lin Tony-B19295 <B19295@freescale.com>
> Cc: Linux USB <linux-usb@vger.kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Subodh Nijsure <snijsure@grid-net.com>
> Cc: Tony Lin <tony.lin@freescale.com>
> Cc: Wolfgang Denk <wd@denx.de>

Quite a CC list, but you forgot the main ones:

FRAMEBUFFER LAYER
M:      Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
L:      linux-fbdev at vger.kernel.org

Patch itself looks good

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120417/db1c2211/attachment.sig>

From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 17 Apr 2012 22:31:54 +0200
Subject: [PATCH] i.MX28: Shut down the LCD controller to avoid bootrom
 sampling bug
In-Reply-To: <201204172210.31232.marex@denx.de>
References: <1334675261-31570-1-git-send-email-marex@denx.de>
 <20120417174824.GD22406@pengutronix.de>
 <201204172210.31232.marex@denx.de>
Message-ID: <20120417203154.GA28067@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Quite a CC list, but you forgot the main ones:
> 
> Do you have a trimmed-down version of the list of mxs-related people possibly?

I usually CC Shawn, alkml and the driver authors and lists. There is
nothing wrong with having more, you just happen to miss the crucial
ones here. 'scripts/get_maintainers.pl' may also be helpful.

> > 
> > FRAMEBUFFER LAYER
> > M:      Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> > L:      linux-fbdev at vger.kernel.org
> > 
> > Patch itself looks good
> 
> Who's applying this? The fbdev people or imx tree?

It is in drivers/video, so it should go via fbdev.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120417/2b21ad48/attachment.sig>

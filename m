From: marex@denx.de (Marek Vasut)
Date: Tue, 17 Apr 2012 22:34:34 +0200
Subject: [PATCH] i.MX28: Shut down the LCD controller to avoid bootrom
 sampling bug
In-Reply-To: <20120417203154.GA28067@pengutronix.de>
References: <1334675261-31570-1-git-send-email-marex@denx.de>
 <201204172210.31232.marex@denx.de> <20120417203154.GA28067@pengutronix.de>
Message-ID: <201204172234.34659.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> > > Quite a CC list, but you forgot the main ones:
> > Do you have a trimmed-down version of the list of mxs-related people
> > possibly?
> 
> I usually CC Shawn, alkml and the driver authors and lists. There is
> nothing wrong with having more, you just happen to miss the crucial
> ones here. 'scripts/get_maintainers.pl' may also be helpful.

A'ight, time for a resend.

> 
> > > FRAMEBUFFER LAYER
> > > M:      Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> > > L:      linux-fbdev at vger.kernel.org
> > > 
> > > Patch itself looks good
> > 
> > Who's applying this? The fbdev people or imx tree?
> 
> It is in drivers/video, so it should go via fbdev.

Right, thanks!

Best regards,
Marek Vasut

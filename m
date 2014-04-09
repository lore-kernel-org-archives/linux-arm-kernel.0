From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 9 Apr 2014 11:41:17 +0800
Subject: [PATCH] pwm: mxs: set pwm_chip can_sleep flag
In-Reply-To: <20140408234418.GL16119@n2100.arm.linux.org.uk>
References: <1396956597-26159-1-git-send-email-shawn.guo@freescale.com>
 <5343FDD3.3070308@i2se.com> <20140408141832.GA8861@piout.net>
 <53442997.70209@i2se.com> <20140408231654.GA13898@piout.net>
 <20140408234418.GL16119@n2100.arm.linux.org.uk>
Message-ID: <20140409034115.GB2611@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 12:44:18AM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 09, 2014 at 01:16:54AM +0200, Alexandre Belloni wrote:
> > I'm not home, else I'll try on my i.mx28 boards...
> 
> I just tried heartbeat here, on iMX6, and it works fine.  That's with this
> in the DT:

FYI. i.MX28 is known as 'mxs' sub-architecture and uses pwm-mxs driver
rather than pwm-imx which is the one for i.MX6.

Shawn

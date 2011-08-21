From: will.deacon@arm.com (Will Deacon)
Date: Sun, 21 Aug 2011 12:25:16 +0100
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
	selection
In-Reply-To: <20110821091851.GI12028@n2100.arm.linux.org.uk>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<1313729819-30301-1-git-send-email-shawn.guo@linaro.org>
	<20110819063533.GR31404@pengutronix.de>
	<20110819110940.GC8918@e102144-lin.cambridge.arm.com>
	<20110819113937.GS31404@pengutronix.de>
	<20110821091851.GI12028@n2100.arm.linux.org.uk>
Message-ID: <20110821112516.GA22917@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2011 at 10:18:51AM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 19, 2011 at 01:39:37PM +0200, Sascha Hauer wrote:
> > One could argue
> > that this option is for people who exactly know what they do only.
> 
> It _IS_ there for people who know what they're doing.  That's something
> I keep on saying about the LL debug stuff.  It's there to allow people
> to debug the early startup of the kernel.  It's not there for users.

Understood. I don't think it hurts to make this explicit in the Kconfig help
entry for DEBUG_LL (as Sascha suggested) so I'll do that for v2 of this
series.

Will

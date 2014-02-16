From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 16 Feb 2014 15:52:27 +0800
Subject: [PATCH] ARM: imx6: fix !CONFIG_PM and !CONFIG_CPU_IDLE build
In-Reply-To: <1392377940.6153.34.camel@weser.hi.pengutronix.de>
References: <1392201948-16311-1-git-send-email-l.stach@pengutronix.de>
 <20140213141944.GC20842@S2101-09.ap.freescale.net>
 <1392377940.6153.34.camel@weser.hi.pengutronix.de>
Message-ID: <20140216075225.GC2946@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 12:39:00PM +0100, Lucas Stach wrote:
> Yes, while thinking about this again it seems to make sense. I first was
> a bit afraid of calling pm_init unconditionally, but aside from a bit
> increased binary size it should be harmless and it simplifies things a
> lot, compared with my patch.
> 
> So feel free to take yours.

Thanks, Lucas.  I will send a formal patch shortly.

Shawn

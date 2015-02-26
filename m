From: ricard.wanderlof@axis.com (Ricard Wanderlof)
Date: Thu, 26 Feb 2015 12:59:31 +0100
Subject: [alsa-devel] [PATCH 1/8] clk: add helper function clk_is_match()
In-Reply-To: <20150226112509.GR30445@trinity.fluff.org>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
 <20150225172757.421.43718@quantum> <20150226090256.GQ30445@trinity.fluff.org>
 <1424944618.3073.6.camel@pengutronix.de>
 <20150226112509.GR30445@trinity.fluff.org>
Message-ID: <alpine.DEB.2.02.1502261259060.17631@lnxricardw1.se.axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 26 Feb 2015, Ben Dooks wrote:

> > > small observaton, clk_is_same() is linguistically nicer.
> > 
> > How about clk_equal() ?
> 
> That's good, the only issue that's not clear in any of these names is
> that does this mean "the same clock", a "clock of the same rate" or a
> "clock that is equivalent to in the rate and phase but not subject to
> the same gate".

clk_identical() ?

/Ricard
-- 
Ricard Wolf Wanderl?f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30

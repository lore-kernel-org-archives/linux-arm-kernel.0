From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Aug 2012 17:00:17 +0100
Subject: [PATCH 06/10 V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <201208021658.38237.marex@denx.de>
References: <1343076052-27312-1-git-send-email-marex@denx.de>
 <1343076052-27312-7-git-send-email-marex@denx.de>
 <20120801203106.GW4483@opensource.wolfsonmicro.com>
 <201208021658.38237.marex@denx.de>
Message-ID: <20120802160016.GA4537@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2012 at 04:58:38PM +0200, Marek Vasut wrote:

> > It'd be nice to only keep the clocks enabled while doing transfers but
> > again totally non-essential.

> Hm, this is spread across mxs. Shawn, is there any plan for PM implementation 
> for MXS ?

Take a look at s3c64xx - I did something with runtime PM for this, it's
something that can reasonably be implemented in drivers and as far as I
can tell most framework implementations end up using runtime PM anyway.

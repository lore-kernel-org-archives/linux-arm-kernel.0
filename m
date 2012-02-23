From: jason@lakedaemon.net (Jason)
Date: Thu, 23 Feb 2012 10:56:57 -0500
Subject: [PATCH 1/3] arm: ignore devicetree blobs.
In-Reply-To: <20120223091630.GA2036@linaro.org>
References: <cover.1312906908.git.jason@lakedaemon.net>
 <cover.1329936660.git.jason@lakedaemon.net>
 <3629df9b5b96d3a3a63a34ebf6ddfca2fd72ccfc.1329936660.git.jason@lakedaemon.net>
 <20120222222619.GY14173@pengutronix.de>
 <20120223091630.GA2036@linaro.org>
Message-ID: <20120223155657.GM23524@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave,

On Thu, Feb 23, 2012 at 09:16:30AM +0000, Dave Martin wrote:
> On Wed, Feb 22, 2012 at 11:26:19PM +0100, Uwe Kleine-K?nig wrote:
> > On Wed, Feb 22, 2012 at 07:18:44PM +0000, Jason Cooper wrote:
> > > 
> > > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> > /me claims prior art:
> > 
> > 	http://mid.gmane.org/1323808612-14976-1-git-send-email-u.kleine-koenig at pengutronix.de
> 
> Multiple people proposed this...
> 
> Grant accepted my patch, and it is already in -next:
> 
> See next-20110222
> 
> 810ae3d26507e61d1f7a69e9716443df1ce41449
> ARM: devicetree: Add .dtb files to arch/arm/boot/.gitignore

awesome, I'll drop this from the next version of the series, then.

thx,

Jason.

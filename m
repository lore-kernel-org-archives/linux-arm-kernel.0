From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 1 Feb 2011 15:03:50 +0100
Subject: [PATCH 3/9] Add a mfd IPUv3 driver
In-Reply-To: <20110201115125.GE31216@n2100.arm.linux.org.uk>
References: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>
	<1292842127-21406-4-git-send-email-s.hauer@pengutronix.de>
	<20110201105127.GA10128@sortiz-mobl>
	<20110201105909.GS9041@pengutronix.de>
	<20110201114453.GC10128@sortiz-mobl>
	<20110201115125.GE31216@n2100.arm.linux.org.uk>
Message-ID: <20110201140349.GA11583@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 11:51:25AM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 01, 2011 at 12:44:54PM +0100, Samuel Ortiz wrote:
> > Ok, so would moving it do drivers/video/ make sense ?
> 
> Isn't that for framebuffer drivers?
Mostly yes, but there are some display controller drivers there as well. See
drivers/video/omap*/.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

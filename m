From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 May 2011 09:22:53 +0300
Subject: [PATCH 01/22] OMAP: sDMA: descriptor autoloading feature
In-Reply-To: <1304596282-4095-2-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
	<1304596282-4095-2-git-send-email-adrian.hunter@nokia.com>
Message-ID: <20110506062252.GT27860@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Adrian Hunter <adrian.hunter@nokia.com> [110505 14:48]:
> From: Venkatraman S <svenkatr@ti.com>
> 
> Add sDMA driver support for descriptor autoloading feature.
>  Descriptor autoloading is OMAP sDMA v5 hardware capability that can be exploited for scatter gather
>  scenarios, currently available in OMAP3630 and OMAP4430.

I think we should not add this feature until after we've
converted omap DMA to use the common dmaengine for the
basic features.

Adding this will make it harder for us to do the converions.

Can you please separate out the DMA descriptor autoloading
patches?

Regards,

Tony

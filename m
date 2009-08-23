From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 23 Aug 2009 19:05:43 +0100
Subject: [alsa-devel] [RFC][PATCH 1/3 v2] ARM: OMAP: DMA: Add support
	for DMA channel self linking on OMAP1510
In-Reply-To: <200908231945.40187.jkrzyszt@tis.icnet.pl>
References: <200908101050.02530.jkrzyszt@tis.icnet.pl>
	<200908231756.13016.jkrzyszt@tis.icnet.pl>
	<20090823170359.GA3488@sirena.org.uk>
	<200908231945.40187.jkrzyszt@tis.icnet.pl>
Message-ID: <20090823180543.GA6167@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 23, 2009 at 07:45:39PM +0200, Janusz Krzysztofik wrote:

> If I missed something and my original patch has really been applied, I'll be 
> happy to prepare a new version that reverts previos changes and makes those 
> proposed in patch v2, if those are acceptable.

If none of your patches have been applied then what are the other
patches that depend on this?  Nobody reported any issues in testing with
the other OMAP patches.

I don't really mind which tree these go via but I rather suspect that
ALSA will be better given all the other changes and I also suspect that
you'll need to regenerate your changes against a current tree due to
those changes.  Tony, are you OK with that?

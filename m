From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Jul 2011 09:56:29 -0700
Subject: [PATCH 6/7] spi/s3c64xx: Add support DMA engine API
In-Reply-To: <20110704164251.GC28042@ponder.secretlab.ca>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<1309781915-31549-7-git-send-email-kgene.kim@samsung.com>
	<20110704164251.GC28042@ponder.secretlab.ca>
Message-ID: <20110704165625.GB28726@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 10:42:51AM -0600, Grant Likely wrote:

> Wow.  A lot of #ifdefs here.  It does not look multiplatform friendly
> at all.  Are the s3c2410_dma functions obsolete when DMADEV_PL330 is
> selected?  If so, can they be removed entirely, or are they required
> to support certain hardware?

My question was going to be if we should split this up into two
different drivers for pretty much these reasons.

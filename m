From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 16 Jul 2012 12:00:46 +0530
Subject: [PATCH] dma: mxs-dma: Export missing symbols from mxs-dma.c
In-Reply-To: <1341579200-13268-1-git-send-email-attila@kinali.ch>
References: <20120706122141.GE22133@S2101-09.ap.freescale.net>
 <1341579200-13268-1-git-send-email-attila@kinali.ch>
Message-ID: <1342420246.1726.43.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-07-06 at 14:53 +0200, Attila Kinali wrote:
> mxs-dma.c provides two functions mxs_dma_is_apbh and mxs_dma_is_apbx
> which are used at least in mxs-mmc.c. Building mxs-mmc as module
> fails due to those two symbols not being exported.
Applied thanks.

Please DO NOT forget to CC maintainers, the patch can get lost
otherwise. get_maintainer.pl is your friend, use it!

-- 
~Vinod

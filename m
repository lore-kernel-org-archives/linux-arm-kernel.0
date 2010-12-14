From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Dec 2010 15:19:23 -0800
Subject: [PATCH v1 0/9] OMAP: DMA: hwmod and DMA as platform device
In-Reply-To: <1291434246-30716-1-git-send-email-manjugk@ti.com>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
Message-ID: <20101214231922.GC14990@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* G, Manjunath Kondaiah <manjugk@ti.com> [101203 19:33]:
> *************************************************************************
> 
> Test Report:
> ************
> Build:
> omap2plus_defconfig    : Success
> omap_osk_5912_defconfig: Success
> 
> Boot:
> OMAP3530Beagle         : Success
> OMAP4430Blaze(ES2.1)   : Success

Can you please make sure that memory to memory DMA test
runs OK on OSK5912?x

AFAIK, Kevin tried it a few days ago and it hung.

To me that sounds like the only remaining issue merging these
in for testing.

Regards,

Tony

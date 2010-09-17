From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Sep 2010 09:41:32 -0700
Subject: [PATCH 01/14] ARM: mmu: Setup MT_MEMORY and
	MT_MEMORY_NONCACHED L1 entries
In-Reply-To: <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20100917164132.GC29610@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [100917 02:40]:
> This patch populates the L1 entries for MT_MEMORY and MT_MEMORY_NONCACHED
> types so that at boot-up, we can map memories outside system memory
> at page level granularity
> 
> Previously the mapping was limiting to section level, which creates
> unnecessary addiotional mapping for which physical memory may not

Minor typo here, it should be "additional".

Tony

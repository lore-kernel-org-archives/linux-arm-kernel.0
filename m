From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Aug 2010 12:35:50 +0100
Subject: [PATCH 1/3] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONACHED
	L1 entries
In-Reply-To: <1281262672-27626-1-git-send-email-santosh.shilimkar@ti.com>
References: <1281262672-27626-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20100808113550.GB23623@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 08, 2010 at 03:47:52PM +0530, Santosh Shilimkar wrote:
> This patch populates the L1 entries for MT_MEMORY and MT_MEMORY_NONACHED

Spelling.

> types so that at boot-up, we can map memories outside system memory
> at page level granularity

If you're only using MT_MEMORY_NONCACHED (it seems so from patch 4),
please only modify that entry.

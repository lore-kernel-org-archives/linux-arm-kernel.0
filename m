From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Mon, 13 Apr 2015 12:13:12 -0700
Subject: [PATCH 6/6] ARM: cleanup early_paging_init() calling
In-Reply-To: <E1YfmYB-0006X7-4U@rmk-PC.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmYB-0006X7-4U@rmk-PC.arm.linux.org.uk>
Message-ID: <552C1548.10406@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/8/2015 2:45 AM, Russell King wrote:
> Eliminate the needless nommu version of this function, and get rid of
> the proc_info_list structure argument - we no longer need this in order
> to fix up the page table entries.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>   arch/arm/kernel/setup.c | 7 ++++---
>   arch/arm/mm/mmu.c       | 6 ++----
>   arch/arm/mm/nommu.c     | 9 ---------
>   3 files changed, 6 insertions(+), 16 deletions(-)
>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

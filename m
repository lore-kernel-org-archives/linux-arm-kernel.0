From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Mon, 13 Apr 2015 12:02:53 -0700
Subject: [PATCH 3/6] ARM: keystone2: move address space switch printk
 to generic code
In-Reply-To: <E1YfmXv-0006Wv-Q1@rmk-PC.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmXv-0006Wv-Q1@rmk-PC.arm.linux.org.uk>
Message-ID: <552C12DD.7090203@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/8/2015 2:45 AM, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>   arch/arm/mach-keystone/keystone.c | 3 ---
>   arch/arm/mm/mmu.c                 | 3 +++
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

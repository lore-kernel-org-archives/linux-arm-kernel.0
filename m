From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Mon, 13 Apr 2015 11:57:59 -0700
Subject: [PATCH 1/6] ARM: keystone2: move platform notifier initialisation
 into platform init
In-Reply-To: <E1YfmXl-0006Wf-HC@rmk-PC.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmXl-0006Wf-HC@rmk-PC.arm.linux.org.uk>
Message-ID: <552C11B7.9050201@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/8/2015 2:45 AM, Russell King wrote:
> We ideally want the init_meminfo function to do nothing but return the
> delta to be applied to PHYS_OFFSET - it should do nothing else.  As we
> can detect in platform init code whether we are running in the high
> physical address space, move the platform notifier initialisation
> entirely into the platform init code.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

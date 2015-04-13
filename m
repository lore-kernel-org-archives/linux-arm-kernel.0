From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Mon, 13 Apr 2015 12:03:41 -0700
Subject: [PATCH 4/6] ARM: keystone2: rename init_meminfo to pv_fixup
In-Reply-To: <E1YfmY0-0006Wz-Tz@rmk-PC.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmY0-0006Wz-Tz@rmk-PC.arm.linux.org.uk>
Message-ID: <552C130D.8000804@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/8/2015 2:45 AM, Russell King wrote:
> The init_meminfo() method is not about initialising meminfo - it's about
> fixing up the physical to virtual translation so that we use a different
> physical address space, possibly above the 4GB physical address space.
> Therefore, the name "init_meminfo()" is confusing.
>
Indeed.

> Rename it to pv_fixup() instead.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

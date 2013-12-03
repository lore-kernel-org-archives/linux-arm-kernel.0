From: tj@kernel.org (Tejun Heo)
Date: Tue, 3 Dec 2013 17:52:58 -0500
Subject: [PATCH v2 02/23] mm/memblock: debug: don't free reserved array
 if !ARCH_DISCARD_MEMBLOCK
In-Reply-To: <1386037658-3161-3-git-send-email-santosh.shilimkar@ti.com>
References: <1386037658-3161-1-git-send-email-santosh.shilimkar@ti.com>
 <1386037658-3161-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131203225258.GS8277@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 09:27:17PM -0500, Santosh Shilimkar wrote:
...
> Cc: Yinghai Lu <yinghai@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Reviewed-by: Tejun Heo <tj@kernel.org>

> +	/*
> +	 * Don't allow Nobootmem allocator to free reserved memory regions

Extreme nitpick: why the capitalization of "Nobootmem"?

Thanks.

-- 
tejun

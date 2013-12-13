From: tj@kernel.org (Tejun Heo)
Date: Fri, 13 Dec 2013 16:21:34 -0500
Subject: [PATCH v3 05/23] mm/memblock: drop WARN and use SMP_CACHE_BYTES
 as a default alignment
In-Reply-To: <1386625856-12942-6-git-send-email-santosh.shilimkar@ti.com>
References: <1386625856-12942-1-git-send-email-santosh.shilimkar@ti.com>
 <1386625856-12942-6-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131213212134.GJ27070@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 04:50:38PM -0500, Santosh Shilimkar wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Don't produce warning and interpret 0 as "default align" equal to
> SMP_CACHE_BYTES in case if caller of memblock_alloc_base_nid() doesn't
> specify alignment for the block (align == 0).
> 
> This is done in preparation of introducing common memblock alloc
> interface to make code behavior consistent. More details are
> in below thread :
> 	https://lkml.org/lkml/2013/10/13/117.
> 
> Cc: Yinghai Lu <yinghai@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Reviewed-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

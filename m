From: tj@kernel.org (Tejun Heo)
Date: Fri, 13 Dec 2013 16:22:29 -0500
Subject: [PATCH v3 06/23] mm/memblock: reorder parameters of
 memblock_find_in_range_node
In-Reply-To: <1386625856-12942-7-git-send-email-santosh.shilimkar@ti.com>
References: <1386625856-12942-1-git-send-email-santosh.shilimkar@ti.com>
 <1386625856-12942-7-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131213212229.GK27070@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 04:50:39PM -0500, Santosh Shilimkar wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Reorder parameters of memblock_find_in_range_node to be consistent
> with other memblock APIs.
> 
> The change was suggested by Tejun Heo <tj@kernel.org>.
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

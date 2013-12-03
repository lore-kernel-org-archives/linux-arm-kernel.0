From: tj@kernel.org (Tejun Heo)
Date: Tue, 3 Dec 2013 17:53:46 -0500
Subject: [PATCH v2 03/23] mm/bootmem: remove duplicated declaration of
 __free_pages_bootmem()
In-Reply-To: <1386037658-3161-4-git-send-email-santosh.shilimkar@ti.com>
References: <1386037658-3161-1-git-send-email-santosh.shilimkar@ti.com>
 <1386037658-3161-4-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131203225346.GT8277@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 09:27:18PM -0500, Santosh Shilimkar wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> The __free_pages_bootmem is used internally by MM core and
> already defined in internal.h. So, remove duplicated declaration.
> 
> Cc: Yinghai Lu <yinghai@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Reviewed-by: Tejun Heo <tj@kernel.org>

-- 
tejun

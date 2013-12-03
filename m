From: tj@kernel.org (Tejun Heo)
Date: Tue, 3 Dec 2013 17:54:17 -0500
Subject: [PATCH v2 04/23] mm/memory_hotplug: remove unnecessary inclusion
 of bootmem.h
In-Reply-To: <1386037658-3161-5-git-send-email-santosh.shilimkar@ti.com>
References: <1386037658-3161-1-git-send-email-santosh.shilimkar@ti.com>
 <1386037658-3161-5-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131203225417.GU8277@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 09:27:19PM -0500, Santosh Shilimkar wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Clean-up to remove depedency with bootmem headers.
> 
> Cc: Yinghai Lu <yinghai@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Reviewed-by: Tejun Heo <tj@kernel.org>

-- 
tejun

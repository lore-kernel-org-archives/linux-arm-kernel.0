From: tj@kernel.org (Tejun Heo)
Date: Tue, 3 Dec 2013 17:58:15 -0500
Subject: [PATCH v2 07/23] mm/memblock: drop WARN and use SMP_CACHE_BYTES
 as a default alignment
In-Reply-To: <1386037658-3161-8-git-send-email-santosh.shilimkar@ti.com>
References: <1386037658-3161-1-git-send-email-santosh.shilimkar@ti.com>
 <1386037658-3161-8-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131203225815.GW8277@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 09:27:22PM -0500, Santosh Shilimkar wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> drop WARN and use SMP_CACHE_BYTES as a default alignment in
> memblock_alloc_base_nid() as recommended by Tejun Heo in
> https://lkml.org/lkml/2013/10/13/117.

Can you please add description on why this change is being made?  This
is in preparation of common alloc interface, right?  The patch
description is kinda out-of-blue.

Thanks.

-- 
tejun

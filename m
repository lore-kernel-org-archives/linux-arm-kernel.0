From: minchan@kernel.org (Minchan Kim)
Date: Thu, 12 Jun 2014 16:16:15 +0900
Subject: [PATCH v2 08/10] mm, cma: clean-up cma allocation error path
In-Reply-To: <1402543307-29800-9-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-9-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <20140612071615.GK12415@bbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 12:21:45PM +0900, Joonsoo Kim wrote:
> We can remove one call sites for clear_cma_bitmap() if we first
> call it before checking error number.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Acked-by: Minchan Kim <minchan@kernel.org>

-- 
Kind regards,
Minchan Kim

From: minchan@kernel.org (Minchan Kim)
Date: Tue, 22 May 2012 15:58:39 +0900
Subject: [PATCHv2 1/4] mm: vmalloc: use const void * for caller argument
In-Reply-To: <1337252085-22039-2-git-send-email-m.szyprowski@samsung.com>
References: <1337252085-22039-1-git-send-email-m.szyprowski@samsung.com>
 <1337252085-22039-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <4FBB391F.8030402@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2012 07:54 PM, Marek Szyprowski wrote:

> 'const void *' is a safer type for caller function type. This patch
> updates all references to caller function type.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>


Reviewed-by: Minchan Kim <minchan@kernel.org>

-- 
Kind regards,
Minchan Kim

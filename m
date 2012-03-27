From: rkuo@codeaurora.org (Richard Kuo)
Date: Tue, 27 Mar 2012 11:41:40 -0500
Subject: [PATCHv2 10/14] Hexagon: adapt for dma_map_ops changes
In-Reply-To: <1332855768-32583-11-git-send-email-m.szyprowski@samsung.com>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
 <1332855768-32583-11-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120327164140.GA3916@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 03:42:44PM +0200, Marek Szyprowski wrote:
> Adapt core Hexagon architecture code for dma_map_ops changes: replace
> alloc/free_coherent with generic alloc/free methods.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/hexagon/include/asm/dma-mapping.h |   18 ++++++++++++------
>  arch/hexagon/kernel/dma.c              |    9 +++++----
>  2 files changed, 17 insertions(+), 10 deletions(-)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org> 

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

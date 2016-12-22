From: jun.nie@linaro.org (Jun Nie)
Date: Thu, 22 Dec 2016 14:17:50 +0800
Subject: [PATCH 2/3] dma: zx: set DMA_CYCLIC cap_mask bit
In-Reply-To: <1481810617-7650-2-git-send-email-shawnguo@kernel.org>
References: <1481810617-7650-1-git-send-email-shawnguo@kernel.org>
 <1481810617-7650-2-git-send-email-shawnguo@kernel.org>
Message-ID: <CABymUCPgYT2paNSXmgdHsKe5bVa04rdcp8+fJOPJQ2Ate4fOyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-12-15 22:03 GMT+08:00 Shawn Guo <shawnguo@kernel.org>:
> From: Shawn Guo <shawn.guo@linaro.org>
>
> The zx_dma driver supports cyclic transfer mode.  Let's set DMA_CYCLIC
> cap_mask bit to make that clear, and avoid unnecessary failure when
> clients request channel via dma_request_chan_by_mask() with DMA_CYCLIC
> bit set in mask.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/dma/zx_dma.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by:  Jun Nie <jun.nie@linaro.org>

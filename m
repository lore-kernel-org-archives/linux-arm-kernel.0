From: rizhao@nvidia.com (Richard Zhao)
Date: Thu, 22 Aug 2013 13:19:05 +0800
Subject: [PATCH] DMA: let filter functions of of_dma_simple_xlate
 possible check of_node
In-Reply-To: <1375408800-11789-1-git-send-email-rizhao@nvidia.com>
References: <1375408800-11789-1-git-send-email-rizhao@nvidia.com>
Message-ID: <20130822051904.GA2685@rizhao-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 10:00:00AM +0800, Richard Zhao wrote:
> pass of_phandle_args dma_spec to dma_request_channel in of_dma_simple_xlate,
> so the filter function could access of_node in of_phandle_args.
> 
> It also remove restriction of #dma-cells has to be one.
> 
> Signed-off-by: Richard Zhao <rizhao@nvidia.com>
> ---
>  drivers/dma/edma.c     |  7 +++++--
>  drivers/dma/of-dma.c   | 10 ++++------
>  drivers/dma/omap-dma.c |  6 ++++--
>  3 files changed, 13 insertions(+), 10 deletions(-)
> 

Hi Vinod,

Can you please pick up this change?

Hi Stephen,

Can you please give a ack or reviewed-by etc?

Thanks
Richard

From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 13 Nov 2013 19:46:30 +0530
Subject: [PATCH 01/13] dma: ste_dma40: Expand DT binding to accept
 'high-priority channel' flag
In-Reply-To: <1383732985-18928-2-git-send-email-lee.jones@linaro.org>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
 <1383732985-18928-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20131113141630.GC8834@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 10:16:13AM +0000, Lee Jones wrote:
> This is used for MSP (audio) devices which is about to be fully DT:ed.
> 
> Cc: devicetree at vger.kernel.org
> Cc: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>

--
~Vinod
> ---
>  Documentation/devicetree/bindings/dma/ste-dma40.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ste-dma40.txt b/Documentation/devicetree/bindings/dma/ste-dma40.txt
> index a8c21c2..1f5729f 100644
> --- a/Documentation/devicetree/bindings/dma/ste-dma40.txt
> +++ b/Documentation/devicetree/bindings/dma/ste-dma40.txt
> @@ -50,6 +50,9 @@ Each dmas request consists of 4 cells:
>          0x00000008: Use fixed channel:
>                  Use automatic channel selection when unset
>                  Use DMA request line number when set
> +        0x00000010: Set channel as high priority:
> +                Normal priority when unset
> +                High priority when set
>  
>  Example:
>  
> -- 
> 1.8.1.2
> 

-- 

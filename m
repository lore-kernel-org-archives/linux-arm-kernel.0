From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 17 Apr 2015 23:59:37 +0530
Subject: [PATCH v3] dmaengine: xgene-dma: Fix sparse wannings and
 coccinelle warnings
In-Reply-To: <1429212673-22254-1-git-send-email-rsahu@apm.com>
References: <1429212673-22254-1-git-send-email-rsahu@apm.com>
Message-ID: <20150417182937.GN30624@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>  	/* Get DMA error interrupt */
> @@ -2076,7 +2035,6 @@ static struct platform_driver xgene_dma_driver = {
>  	.remove = xgene_dma_remove,
>  	.driver = {
>  		.name = "X-Gene-DMA",
> -		.owner = THIS_MODULE,
I have already applied a patch for this

>  		.of_match_table = xgene_dma_of_match_ptr,
>  	},
>  };
> @@ -2085,6 +2043,5 @@ module_platform_driver(xgene_dma_driver);
> 
>  MODULE_DESCRIPTION("APM X-Gene SoC DMA driver");
>  MODULE_AUTHOR("Rameshwar Prasad Sahu <rsahu@apm.com>");
> -MODULE_AUTHOR("Loc Ho <lho@apm.com>");
And why this?

Fixes looks good though

-- 
~Vinod
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION("1.0");
> --
> 1.8.2.1
> 

-- 

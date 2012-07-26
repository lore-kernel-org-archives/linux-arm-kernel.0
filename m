From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Thu, 26 Jul 2012 12:21:15 +0530
Subject: [PATCH 1/3] dmaengine: mmp-pdma support
In-Reply-To: <1342763164-19208-2-git-send-email-zhangfei.gao@marvell.com>
References: <1342763164-19208-1-git-send-email-zhangfei.gao@marvell.com>
 <1342763164-19208-2-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <1343285475.1726.8981.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-07-20 at 13:46 +0800, Zhangfei Gao wrote:
> +struct mmp_dma_platdata {
> +       int chancnt;
> +};
> +
> +struct mmp_dma_slave_config {
> +       struct dma_slave_config slave_config;
> +       u32 drcmr;
> +};
Why do you need these definitions?

What is drcmr used for?


-- 
~Vinod

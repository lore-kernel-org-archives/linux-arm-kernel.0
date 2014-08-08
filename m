From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 8 Aug 2014 22:43:28 +0530
Subject: [PATCH] dmaengine: sun6i: depends on RESET_CONTROLLER
In-Reply-To: <1407430844-30498-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1407430844-30498-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140808171328.GA13288@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 07, 2014 at 07:00:44PM +0200, Maxime Ripard wrote:
> Fixes a compilation error when RESET_CONTROLLER is not enabled in the
> configuration.
> 
> drivers/dma/sun6i-dma.c: In function 'sun6i_dma_probe':
> drivers/dma/sun6i-dma.c:911:2: error: implicit declaration of function 'devm_reset_control_get' [-Werror=implicit-function-declaration]

Applied, thanks

-- 
~Vinod

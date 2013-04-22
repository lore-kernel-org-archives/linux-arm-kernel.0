From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 22 Apr 2013 15:47:41 +0530
Subject: [PATCH 24/32 v2] dmaengine: ste_dma40: Supply full Device Tree
 parsing support
In-Reply-To: <20130418121253.GF27903@gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-25-git-send-email-lee.jones@linaro.org>
 <20130418121253.GF27903@gmail.com>
Message-ID: <20130422101741.GS24632@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 01:12:53PM +0100, Lee Jones wrote:
> Using the new DMA DT bindings and API, we can register the DMA40 driver
> as Device Tree capable. Now, when a client attempts to allocate a
> channel using the DMA DT bindings via its own node, we are able to parse
> the request and allocate a channel in the correct manner.
> +
> +	switch (D40_DT_FLAGS_MODE(flags)) {
> +	case 0: cfg.mode = STEDMA40_MODE_LOGICAL; break;
> +	case 1: cfg.mode = STEDMA40_MODE_PHYSICAL; break;
ah there was a v2, i need to see the thread, this one still needs to be fixed
though

--
~Vinod

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 26 Jul 2013 13:25:20 -0600
Subject: [PATCH 0/9] ARM: tegra: move to generic DMA DT binding
In-Reply-To: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
Message-ID: <51F2CD20.6030700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 10:09 PM, Richard Zhao wrote:
> The patch series aim to move apbdma to generic DT binding.
> 
> Changes:
> - It add dmas/dma-names properties while leave
>   nvidia,dma-request-selector to be compatible.
> - update apbdma driver and dma client drivers
> - ASoC tegra adds a new struct to pass device and dma-name.
> - at last, remove legacy nvidia,dma-request-selector

I would like to take this series through the Tegra tree to simplify
dependencies. So, I'm looking for ack's on the drivers rather than for
them to be applied. I had hoped Richard would point this out when
posting the patches.

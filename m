From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 24 Apr 2015 14:10:41 +0200
Subject: [PATCH V2] ARM: dts: imx28: Fix AUART4 TX-DMA interrupt name
In-Reply-To: <1429874987-5481-1-git-send-email-marex@denx.de>
References: <1429874987-5481-1-git-send-email-marex@denx.de>
Message-ID: <553A32C1.6090405@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.04.2015 um 13:29 schrieb Marek Vasut:
> Fix a typo in the TX DMA interrupt name for AUART4.
> This patch makes AUART4 operational again.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: stable at vger.kernel.org
> ---
>  Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt | 2 +-
>  arch/arm/boot/dts/imx28.dtsi                          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> V2: Update the Documentation as well (thanks to Stefan Wahren for spotting this)
>
> [...]

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks

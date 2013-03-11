From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Mar 2013 16:15:13 -0600
Subject: [PATCH V2 0/5] ARM: DT: tegra114: Add DT entry for different
 controller
In-Reply-To: <1362852678-13421-1-git-send-email-ldewangan@nvidia.com>
References: <1362852678-13421-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <513E5771.9000408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2013 11:11 AM, Laxman Dewangan wrote:
> This patch series add DT entry for APB DMA, I2C, UART, KBC and SPI.
> 
> This patch series is generated on top of CCF work for T114 done by Peter
> and hence it should be applied on top of T114 CCF patches.
> 
> Changes from V1:
> - Add reeason why APBDMA is not compatible with older driver
>   in description.
> - Remove UARTB car id correction. Make the compatible with tegra114 and
>   older chip.
> - Add compatible for kbc as nvidia,tegra114-kbc and nvidia,tegra20-kbc.
> 
> Laxman Dewangan (5):
>   ARM: DT: tegra114: add APB DMA controller DT entry
>   ARM: DT: tegra114: Add i2c controller DT entry
>   ARM: DT: tegra114:add aliases and DMA requestor for serial controller
>   ARM: DT: tegra114: add KBC controller DT entry
>   ARM: DT: tegra114: Add spi controller DT entry

What branch is this series based on? I tried to apply these for testing,
but git am failed to apply it to Tegra's for-3.10/dt, and Tegra's
for-next, and my local work branch, and next-20130307.

Can you please rebase onto Tegra's for-3.10/dt. Thanks.

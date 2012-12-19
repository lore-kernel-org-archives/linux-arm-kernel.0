From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 19 Dec 2012 10:00:59 -0700
Subject: [PATCH] ARM: tegra: dts: add aliases and DMA requestor for serial
 controller
In-Reply-To: <1355898671-3960-1-git-send-email-ldewangan@nvidia.com>
References: <1355898671-3960-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <50D1F2CB.3090206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2012 11:31 PM, Laxman Dewangan wrote:
> Add APB DMA requestor and serial aliases for serial controller.
> There will be two serial driver i.e. 8250 based simple serial driver
> and APB DMA based serial driver for higher baudrate and performace.
> 
> The simple serial driver get enabled with compatible nvidia,tegra20-uart
> and APB DMA based driver will get enabled with compatible
> nvidia,tegra20-hsuart.

This patch seems to do two things:

1) Add a comment describing how to select the basic or DMA-based driver.
I can see why this is useful.

2) Add aliases for the serial ports. I have no idea why this is useful.

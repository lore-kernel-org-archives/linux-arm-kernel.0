From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 22:52:26 +0200
Subject: [GIT PULL]Hisilicon Hi6220 SoC and Hikey board DT updates for 4.7
In-Reply-To: <57121CD9.4010606@hisilicon.com>
References: <57121CD9.4010606@hisilicon.com>
Message-ID: <5439238.hA1QartboN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 April 2016 12:07:05 Wei Xu wrote:
> ARM64: DT: Hisilicon Hi6220 soc and hikey board updates for 4.7
> 
> - Reserve memory regions for Hi6220
> - Add sp804 timer node for Hi6220
> - Add cpu and cluster level's low power state for Hi6220
> - Add gpio configuration nodes for Hi6220
> - Add pinctrl configuration nodes for Hi6220
> - Add spi related nodes for Hi6220
> - Add i2c nodes for Hi6220
> - Add i2c nodes to work with mezzanine boards
> - Add usb nodes for Hi6220
> - Add mailobx node for Hi6220
> - Add SRAM node and stub clock node for Hi6220
> - Add pinctrl nodes for uarts and enable them
> - Add LED nodes for hi6220-hikey board
> - Add hi655x pmic node for Hi6220
> - Add dwmmc nodes for Hi6220
> - Add wifi nodes support for Hi6220-Hikey board
> - Register thermal sensor for Hi6220
> - Register Hi6220's thermal zone for power allocator
> - Add L2 cache topology for Hi6220
> 

Pulled into next/dt64, thanks!

	Arnd

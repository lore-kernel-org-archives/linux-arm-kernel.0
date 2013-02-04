From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 4 Feb 2013 14:25:15 +0530
Subject: [PATCHv2 0/2] add omap mcspi device tree data
In-Reply-To: <1359967907-26645-1-git-send-email-sourav.poddar@ti.com>
References: <1359967907-26645-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <510F7773.5060102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 February 2013 02:21 PM, Sourav Poddar wrote:
> Patch series adds omap5 evm mcspi nodes and pinctrl
> data in omap5.dtsi and omap5-evm.dts files.
>
> Felipe Balbi (1):
>    arm: dts: omap5: add SPI devices to OMAP5 DeviceTree file
>
> Sourav Poddar (1):
>    arm: dts: omap5-evm: Add mcspi data
>
>   arch/arm/boot/dts/omap5-evm.dts |   46 +++++++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/omap5.dtsi    |   40 +++++++++++++++++++++++++++++++++
>   2 files changed, 86 insertions(+), 0 deletions(-)
>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

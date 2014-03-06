From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Mar 2014 15:10:59 -0500
Subject: [PATCH v2] ARM: mvebu: add Device Tree for the Armada 385 RD board
In-Reply-To: <1394119075-18657-1-git-send-email-gregory.clement@free-electrons.com>
References: <1394119075-18657-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140306201059.GI1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 04:17:55PM +0100, Gregory CLEMENT wrote:
> The Armada 385 RD board is the reference design board from Marvell
> for the Armada 385 SoC. This commit adds a Device Tree description for
> this board, which enables the following features:
> 
>  * Network interfaces
>  * I2C bus
>  * Serial port
>  * SPI bus, with a SPI flash
>  * PCIe interface
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> Changelog:
> v1 -> v2:
> 
> - used the phy-mode "rgmii-id" to be able to work with the Marvell PHY
>   driver enabled
> 
> - put the ethernet nodes in the address order, as it has no effect to
>   change ti at this level (should be done at dtsi level)
> 
> - inverted the phy devices (which was improperly assigned in v1)
> 
> - added the vendor prefix for the SPI flash
> 
> 
>  arch/arm/boot/dts/Makefile          |  3 +-
>  arch/arm/boot/dts/armada-385-rd.dts | 94 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 96 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/armada-385-rd.dts

Applied to mvebu/dt

thx,

Jason.

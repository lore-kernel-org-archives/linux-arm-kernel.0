From: robh@kernel.org (Rob Herring)
Date: Thu, 4 Aug 2016 13:22:00 -0500
Subject: [PATCH v2 17/17] ARM: dts: mvebu: armada-395-gp: add support for
 the Armada 395 GP Board
In-Reply-To: <1470305660-6601-18-git-send-email-jaz@semihalf.com>
References: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
 <1470305660-6601-18-git-send-email-jaz@semihalf.com>
Message-ID: <20160804182200.GA18186@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 12:14:20PM +0200, Grzegorz Jaszczyk wrote:
> This commit adds description for the following features for this board:
> 
> - Serial port
> - PCIe interfaces
> - USB2.0
> - USB3.0
> - SDIO
> - 1024 MiB NAND-FLASH
> - SATA
> - I2C buses
> 
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/arm/marvell/armada-39x.txt |   4 +
>  arch/arm/boot/dts/armada-395-gp.dts                | 163 +++++++++++++++++++++
>  2 files changed, 167 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-395-gp.dts

Acked-by: Rob Herring <robh@kernel.org>

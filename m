From: robh@kernel.org (Rob Herring)
Date: Wed, 23 Mar 2016 10:03:39 -0500
Subject: [PATCH 1/2] ARM: dts: am335x: Add initial support for ICEv2 board
In-Reply-To: <1458628657-30468-2-git-send-email-lokeshvutla@ti.com>
References: <1458628657-30468-1-git-send-email-lokeshvutla@ti.com>
 <1458628657-30468-2-git-send-email-lokeshvutla@ti.com>
Message-ID: <20160323150339.GA10417@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 12:07:36PM +0530, Lokesh Vutla wrote:
> TI's Industrial Communication Engine EVM is a low cost hardware mainly
> developed for industrial communication type applications using serial
> or Ethernet based interfaces. This platform features TI's AM3359 with
> 800MHz single core Cortex-A8 processor, 256MB DDR3, 64MB SPI flash,
> 8MB NOR Flash, mmc, usb, can, dual Ethernet ports.
> 
> For more information, look at HW user guide[1], Data manual[2].
> 
> Just add basic support for the moment.
> 
> [1] http://processors.wiki.ti.com/index.php/AM335x_Industrial_Communication_Engine_EVM_Rev2_1_HW_User_Guide
> [2] http://www.ti.com/lit/ds/symlink/am3359.pdf
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  .../devicetree/bindings/arm/omap/omap.txt          |   3 +

Acked-by: Rob Herring <robh@kernel.org>

>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/am335x-icev2.dts                 | 303 +++++++++++++++++++++
>  3 files changed, 307 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am335x-icev2.dts

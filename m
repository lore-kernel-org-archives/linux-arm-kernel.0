From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 7 Mar 2013 17:43:37 +0100
Subject: [PATCH 0/5] Device Bus support for Marvell EBU SoC
In-Reply-To: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130307174337.233ec8df@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Thu,  7 Mar 2013 09:54:20 -0300, Ezequiel Garcia wrote:

> Ezequiel Garcia (5):
>   drivers: memory: Introduce Marvell EBU Device Bus driver
>   ARM: mvebu: Add Device Bus support for Armada 370/XP SoC
>   ARM: mvebu: Add support for NOR flash device on Armada XP-GP board
>   ARM: mvebu: Add support for NOR flash device on Openblocks AX3 board
>   ARM: mvebu: Update defconfig to select Device Bus (memory-controller)
>     support
> 
>  .../bindings/memory-controllers/orion-devbus.txt   |  150 ++++++++++
>  arch/arm/boot/dts/armada-370.dtsi                  |    7 +
>  arch/arm/boot/dts/armada-xp-gp.dts                 |   12 +
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |   12 +
>  arch/arm/boot/dts/armada-xp.dtsi                   |    7 +
>  arch/arm/configs/mvebu_defconfig                   |    2 +
>  drivers/memory/Kconfig                             |   11 +
>  drivers/memory/Makefile                            |    1 +
>  drivers/memory/mvebu-devbus.c                      |  296 ++++++++++++++++++++
>  9 files changed, 498 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/orion-devbus.txt
>  create mode 100644 drivers/memory/mvebu-devbus.c

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 (on Armada XP GP board)

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

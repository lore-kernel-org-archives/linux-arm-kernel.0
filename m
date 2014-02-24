From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 24 Feb 2014 20:11:08 +0100
Subject: [PATCH v2 2/5] ARM: mvebu: Add i2c alias so setting bus number
In-Reply-To: <20140224190509.GD1010@titan.lakedaemon.net>
References: <1393264898-28939-1-git-send-email-andrew@lunn.ch>
 <1393264898-28939-3-git-send-email-andrew@lunn.ch>
 <20140224190509.GD1010@titan.lakedaemon.net>
Message-ID: <20140224191108.GA29288@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 02:05:09PM -0500, Jason Cooper wrote:
> Subject should be "ARM: kirkwood: ..."

Humm, why?

linux/arch/arm/boot/dts$ git log --oneline armada-370.dtsi 
a095b1c78a35 ARM: mvebu: sort DT nodes by address
d4fa99417a07 ARM: mvebu: link PCIe controllers to the MSI controller
238493e34d3f ARM: dts: mvebu: Update with the new compatible string for mv64xxx-
6cbe0e1feaf8 Merge tag 'dt-3.12' of git://git.infradead.org/linux-mvebu into nex
5d3b88307176 ARM: mvebu: Fix the Armada 370/XP timer compatible strings
ca60985c0042 ARM: mvebu: use correct #interrupt-cells instead of #interrupts-cel
14fd8ed0a7fd ARM: mvebu: Relocate Armada 370/XP PCIe device tree nodes
0cd3754a8317 ARM: mvebu: Add BootROM to Armada 370/XP device tree
5e12a613ce39 ARM: mvebu: Add MBus to Armada 370/XP device tree
38149887ef8b ARM: mvebu: Use the preprocessor on Armada 370/XP device tree files
9214cbe50fe7 Merge tag 'dt-3.11-5' of git://git.infradead.org/users/jcooper/linu
83735101959e ARM: mvebu: Remove device tree unused properties on A370
489e138eec96 ARM: dts: mvebu: Fix wrong the address reg value for the L2-cache n
8eed481e6fe2 arm: mvebu: fix the 'ranges' property to handle PCIe

Seems to me, now that it is part of mach-mvebu, ARM: mvebu is correct.

      Andrew

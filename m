From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 4 Feb 2013 13:51:20 -0300
Subject: [PATCH 0/2] ARM: mvebu: Add support for SPI controller in Armada
 370/XP
In-Reply-To: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130204165119.GA2440@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds support for the SPI controller
available in Armada 370 and Armada XP SoC.

The patches are based in Jason Cooper's mvebu/dt branch.

Feel free to test and/or provide feedback.

Ezequiel Garcia (2):
 ARM: mvebu: Update defconfig to select SPI support
 ARM: mvebu: Add support for SPI controller in Armada 370/XP

 arch/arm/boot/dts/armada-370-xp.dtsi |   22 ++++++++++++++++++++++
 arch/arm/configs/mvebu_defconfig     |    2 ++
 2 files changed, 24 insertions(+), 0 deletions(-)

Thanks,

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

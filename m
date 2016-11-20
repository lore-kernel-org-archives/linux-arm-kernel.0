From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 20 Nov 2016 19:10:37 +0530
Subject: [GIT PULL 3/4] DaVinci DT updates for v4.10 (part 2)
In-Reply-To: <20161120134038.14998-1-nsekhar@ti.com>
References: <20161120134038.14998-1-nsekhar@ti.com>
Message-ID: <20161120134038.14998-3-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1b499f255589204466d8f8ab26e6b577d7b5c88f:

  ARM: dts: da850: Add cfgchip syscon node (2016-11-01 15:11:10 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git davinci-for-v4.10/dt-2

for you to fetch changes up to 83de086cc89410a8d4e0b6345e8a1116797ea703:

  ARM: dts: da850-lcdk: Enable the usb otg device node (2016-11-20 17:02:18 +0530)

----------------------------------------------------------------
Adds device tree nodes enabling DDR controller
and bus master priority settings needed for
stable LCDC operation on DA850.

Also adds support for MUSB device on DA850
providing USB OTG support.

----------------------------------------------------------------
Alexandre Bailon (2):
      ARM: dts: da850: Add the usb otg device node
      ARM: dts: da850-lcdk: Enable the usb otg device node

Bartosz Golaszewski (1):
      ARM: dts: da850: add the mstpri and ddrctl nodes

 arch/arm/boot/dts/da850-lcdk.dts |  8 ++++++++
 arch/arm/boot/dts/da850.dtsi     | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

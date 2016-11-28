From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 28 Nov 2016 17:12:18 +0530
Subject: [GIT PULL 3/4] DaVinci DT updates for v4.10 (part 3)
In-Reply-To: <20161128114219.22325-1-nsekhar@ti.com>
References: <20161128114219.22325-1-nsekhar@ti.com>
Message-ID: <20161128114219.22325-4-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 83de086cc89410a8d4e0b6345e8a1116797ea703:

  ARM: dts: da850-lcdk: Enable the usb otg device node (2016-11-20 17:02:18 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.10/dt-3

for you to fetch changes up to 878e908ad95637dc6567a9b5f6876a580ae90dfa:

  ARM: dts: da850: enable memctrl and mstpri nodes per board (2016-11-28 15:51:29 +0530)

----------------------------------------------------------------
Some fixes for device-tree patches already queued.
- Fix SD card detect polarity
- Prevent Ethernet from picking a random mac address
- Fix error messages on platforms which dont use
  bus master and emif priority settings.

----------------------------------------------------------------
Axel Haslam (1):
      ARM: dts: da850-lcdk: fix mmc card detect polarity

Bartosz Golaszewski (1):
      ARM: dts: da850: enable memctrl and mstpri nodes per board

Fabien Parent (1):
      ARM: dts: da850-lcdk: Add ethernet0 alias to DT

 arch/arm/boot/dts/da850-lcdk.dts | 11 ++++++++++-
 arch/arm/boot/dts/da850.dtsi     |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

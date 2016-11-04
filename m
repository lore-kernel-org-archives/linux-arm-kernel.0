From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 4 Nov 2016 11:55:34 +0530
Subject: [GIT PULL 3/4] DaVinci device-tree updates for v4.10
In-Reply-To: <20161104062535.9593-1-nsekhar@ti.com>
References: <20161104062535.9593-1-nsekhar@ti.com>
Message-ID: <20161104062535.9593-3-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.10/dt

for you to fetch changes up to 1b499f255589204466d8f8ab26e6b577d7b5c88f:

  ARM: dts: da850: Add cfgchip syscon node (2016-11-01 15:11:10 +0530)

----------------------------------------------------------------
DaVinci device-tree source additions for
LCD, SPI and cfgchip syscon.

----------------------------------------------------------------
David Lechner (2):
      ARM: dts: da850: Add DMA to SPI0
      ARM: dts: da850: Add cfgchip syscon node

Karl Beldan (1):
      ARM: dts: da850: add a node for the LCD controller

 arch/arm/boot/dts/da850.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

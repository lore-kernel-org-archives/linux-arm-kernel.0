From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 2 Feb 2017 19:03:47 +0530
Subject: [GIT PULL 3/4] DaVinci device-tree updates (part 2)
In-Reply-To: <20170202133348.32713-1-nsekhar@ti.com>
References: <20170202133348.32713-1-nsekhar@ti.com>
Message-ID: <20170202133348.32713-3-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4302a38ef6f1ebdbdec886bcc7b2d27654e50aea:

  ARM: dts: Add LEGO MINDSTORMS EV3 dts (2017-01-20 17:17:29 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.11/dt-2

for you to fetch changes up to 91aba937086daedba96c3227b40697b7c4da1520:

  ARM: dts: da850-lcdk: enable the SATA node (2017-01-31 17:52:35 +0530)

----------------------------------------------------------------
Enable SATA support on DA850 LCDK

----------------------------------------------------------------
Bartosz Golaszewski (3):
      devicetree: bindings: add bindings for ahci-da850
      ARM: dts: da850: add the SATA node
      ARM: dts: da850-lcdk: enable the SATA node

 Documentation/devicetree/bindings/ata/ahci-da850.txt | 18 ++++++++++++++++++
 arch/arm/boot/dts/da850-lcdk.dts                     |  4 ++++
 arch/arm/boot/dts/da850.dtsi                         |  6 ++++++
 3 files changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt

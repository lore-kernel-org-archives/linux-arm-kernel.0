From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 17 Apr 2018 15:31:25 +0530
Subject: [PATCH 0/2] ARM: dts: da850: fix warnings related to memory node
Message-ID: <20180417100128.23011-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are fixes to W=1 warnings related to memory nodes in
DA850 device-tree files.

Sekhar Nori (2):
  ARM: dts: da850: get rid of skeleton.dtsi
  ARM: dts: da850-lcdk: add unit name for memory node

 arch/arm/boot/dts/da850-lcdk.dts |  2 +-
 arch/arm/boot/dts/da850.dtsi     | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.16.2

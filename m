From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Apr 2018 14:54:06 +0530
Subject: [PATCH v2 0/2] ARM: dts: da850: fix warnings related to memory node
Message-ID: <20180418092408.2077-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are fixes to W=1 warnings related to memory nodes in
DA850 device-tree files.

v2:
- Address David's comments
- Add devicetree mailing list to recipients.

Sekhar Nori (2):
  ARM: dts: da850: get rid of skeleton.dtsi
  ARM: dts: da850-lcdk: add unit name for memory node

 arch/arm/boot/dts/da850-lcdk.dts |  4 ++--
 arch/arm/boot/dts/da850.dtsi     | 11 ++++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.16.2

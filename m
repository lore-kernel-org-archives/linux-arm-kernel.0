From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Mon, 27 Aug 2012 18:01:52 +0530
Subject: [PATCH 0/2] arm/dts: AM33XX: Add reg and interrupt property for all
 nodes
Message-ID: <1346070714-6122-1-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is trivial patch-series and should be considered as
preparation for the future where we supposed to get rid of
hwmod dependency.

1/2: Converts all hex numbers to lowercase, fixing inconsistency
2/2: Add reg and interrupt property  to all device/module nodes inside
     DTS files. 

Although currently hwmod overwrites resources, I have validated this
patch series by changing the omap_device layer to respect DT resources
and boot Tested on BeagleBone platform.
I will be submitting the changes for omap_device layer as well, still
needs to fix on certain things.

Vaibhav Hiremath (2):
  arm/dts: AM33XX: Convert all hex numbers to lower-case
  arm/dts: AM33XX: Specify reg and interrupt property for all nodes

 arch/arm/boot/dts/am335x-bone.dts |    2 +-
 arch/arm/boot/dts/am335x-evm.dts  |    2 +-
 arch/arm/boot/dts/am33xx.dtsi     |   62 +++++++++++++++++++++++++++++++------
 3 files changed, 54 insertions(+), 12 deletions(-)

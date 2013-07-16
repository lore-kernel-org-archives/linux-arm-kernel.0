From: mgreer@animalcreek.com (Mark A. Greer)
Date: Tue, 16 Jul 2013 16:29:26 -0700
Subject: [PATCH 0/2] ARM: dts: Add SHAM and AES DT information
Message-ID: <1374017368-5267-1-git-send-email-mgreer@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Mark A. Greer" <mgreer@animalcreek.com>

Long overdue patches to add the device tree updates and
documentation for the SHAM and AES modules on the am33xx.
The supporting code is already in the mainline kernel.

Mark A. Greer (2):
  ARM: dts: Add SHAM data and documentation for AM33XX
  ARM: dts: Add AES data and documentation for AM33XX

 .../devicetree/bindings/crypto/omap-aes.txt        | 35 ++++++++++++++++++++++
 .../devicetree/bindings/crypto/omap-sham.txt       | 33 ++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts                  |  8 +++++
 arch/arm/boot/dts/am335x-evm.dts                   |  8 +++++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  7 +++++
 arch/arm/boot/dts/am33xx.dtsi                      | 20 +++++++++++++
 6 files changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-aes.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt

-- 
1.7.12

From: mgreer@animalcreek.com (Mark A. Greer)
Date: Wed, 17 Jul 2013 09:23:40 -0700
Subject: [PATCH v2 0/2] ARM: dts: Add SHAM and AES DT information
Message-ID: <1374078222-12883-1-git-send-email-mgreer@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Mark A. Greer" <mgreer@animalcreek.com>

Long overdue patches to add the device tree updates and
documentation for the SHAM and AES modules on the am33xx.
The supporting code is already in the mainline kernel.

This series is based on the current mainline kernel,
c0d15cc (linked-list: Remove __list_for_each).

Changes from v1:
 - Added missing '};' as pointed out by Lokesh Vutla <lokeshvutla@ti.com>

Mark A. Greer (2):
  ARM: dts: Add SHAM data and documentation for AM33XX
  ARM: dts: Add AES data and documentation for AM33XX

 .../devicetree/bindings/crypto/omap-aes.txt        | 35 ++++++++++++++++++++++
 .../devicetree/bindings/crypto/omap-sham.txt       | 33 ++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts                  |  8 +++++
 arch/arm/boot/dts/am335x-evm.dts                   |  8 +++++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  8 +++++
 arch/arm/boot/dts/am33xx.dtsi                      | 21 +++++++++++++
 6 files changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-aes.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt

-- 
1.7.12

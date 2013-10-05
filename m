From: joelf@ti.com (Joel Fernandes)
Date: Sat, 5 Oct 2013 14:04:34 -0500
Subject: [PATCH v3 0/3] AM33XX crypto DTS patches
Message-ID: <1380999877-20884-1-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are some minor fixups and changes to commit messages to the
AM33XX crypto (aes, sham) patches with reference to the comments at:
http://comments.gmane.org/gmane.linux.drivers.devicetree/45961

Joel Fernandes (1):
  ARM: dts: AM33XX: Fix AES interrupt number

Mark A. Greer (2):
  ARM: dts: AM33XX: Add SHAM data and documentation
  ARM: dts: AM33XX: Add AES data and documentation

 .../devicetree/bindings/crypto/omap-aes.txt        | 31 ++++++++++++++++++++++
 .../devicetree/bindings/crypto/omap-sham.txt       | 28 +++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts                  |  8 ++++++
 arch/arm/boot/dts/am335x-evm.dts                   |  8 ++++++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  8 ++++++
 arch/arm/boot/dts/am33xx.dtsi                      | 19 +++++++++++++
 6 files changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-aes.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt

-- 
1.8.1.2

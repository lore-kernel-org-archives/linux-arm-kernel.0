From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 May 2015 18:11:03 +0200
Subject: [PATCH 0/4] Ux500 Device Tree docs and additions
Message-ID: <1431619867-14700-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches is orthogonal to the other Ux500 cleanups
in that it only hits the device tree files and bindings.

Linus Walleij (4):
  ARM: scu: document Snoop Control Unit DT bindings
  ARM: ux500: add board documentation
  ARM: ux500: add SCU and WD to device tree
  ARM: ux500: define the backupram in the device tree

 Documentation/devicetree/bindings/arm/scu.txt      | 25 +++++++
 .../devicetree/bindings/arm/ux500/boards.txt       | 83 ++++++++++++++++++++++
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  | 21 ++++++
 3 files changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/scu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ux500/boards.txt

-- 
1.9.3

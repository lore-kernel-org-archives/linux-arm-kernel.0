From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 1 Jun 2015 14:29:53 +0200
Subject: [GIT PULL] DT changes for Ux500 and ARM generic
Message-ID: <CACRpkdZHxEDqwnp74qk3PdquivmrPaLZ3rSBfXdpuV73RYd24A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

no comments on these DT bindings and additions,
so could you please pull this to the next/dt branch in ARM SoC?

Yours,
Linus Walleij

The following changes since commit 7dfc635894d1de84145fb02b210e6dfa5f50b6cc:

  ARM: dts: Add DT for Hitex LPC4350 Evaluation Board (2015-05-15
22:28:29 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/dt-for-armsoc

for you to fetch changes up to 724814b4fada4a353728c3caa8ad2809c64893b6:

  ARM: ux500: define the backupram in the device tree (2015-05-18
16:00:11 +0200)

----------------------------------------------------------------
Device Tree changes for Ux500 and ARM SOC:
- Document Snoop Control Unit (SCU) bindings
- Document Ux500 board bindings
- Define the backup RAM in the DBx500 device tree

----------------------------------------------------------------
Linus Walleij (3):
      ARM: scu: document Snoop Control Unit DT bindings
      ARM: ux500: add board documentation
      ARM: ux500: define the backupram in the device tree

 Documentation/devicetree/bindings/arm/scu.txt      | 25 +++++++
 .../devicetree/bindings/arm/ux500/boards.txt       | 83 ++++++++++++++++++++++
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |  9 +++
 3 files changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/scu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ux500/boards.txt

From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Sep 2016 14:50:40 +0800
Subject: [GIT PULL 2/3] ZTE arm64 device tree changes for 4.9
In-Reply-To: <1474008641-30859-1-git-send-email-shawnguo@kernel.org>
References: <1474008641-30859-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1474008641-30859-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/zte-dt64-4.9

for you to fetch changes up to 2e673c7dc37a51f1c1cdabee22615916cbe0fc27:

  arm64: dts: Add ZTE ZX296718 SoC dts and Makefile (2016-09-16 10:47:05 +0800)

----------------------------------------------------------------
ZTE arm64 device tree changes for 4.9:
 - Add initial DTS support for ZTE ZX296718 SoC and ZX296718 EVB board.

----------------------------------------------------------------
Jun Nie (1):
      arm64: dts: Add ZTE ZX296718 SoC dts and Makefile

 Documentation/devicetree/bindings/arm/zte.txt |  24 +++
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/zte/Makefile              |   5 +
 arch/arm64/boot/dts/zte/zx296718-evb.dts      |  64 ++++++
 arch/arm64/boot/dts/zte/zx296718.dtsi         | 292 ++++++++++++++++++++++++++
 5 files changed, 386 insertions(+)
 create mode 100644 arch/arm64/boot/dts/zte/Makefile
 create mode 100644 arch/arm64/boot/dts/zte/zx296718-evb.dts
 create mode 100644 arch/arm64/boot/dts/zte/zx296718.dtsi

From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 29 Jun 2016 17:25:16 +0100
Subject: [GIT PULL] Immutable branch between MFD, Regulator and ARM for v4.8
In-Reply-To: <20160629055322.23038-1-stefan@agner.ch>
References: <20160629055322.23038-1-stefan@agner.ch>
Message-ID: <20160629162516.GB1707@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enjoy!

The following changes since commit af8c34ce6ae32addda3788d54a7e340cad22516b:

  Linux 4.7-rc2 (2016-06-05 14:31:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-regulator-arm-v4.8

for you to fetch changes up to a370f60a58ec7bad7045803041524ccdc4d79c75:

  mfd: rn5t618: Register restart handler (2016-06-29 10:11:35 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Regulator and ARM, due for v4.8

----------------------------------------------------------------
Stefan Agner (5):
      ARM: dts: meson: minix-neo-x8: define PMIC as power controller
      mfd: rn5t618: Add Ricoh RN5T567 PMIC support
      regulator: rn5t618: Add RN5T567 PMIC support
      mfd: rn5t618: Register power off callback optionally
      mfd: rn5t618: Register restart handler

 Documentation/devicetree/bindings/mfd/rn5t618.txt | 19 +++---
 arch/arm/boot/dts/meson8-minix-neo-x8.dts         |  1 +
 drivers/mfd/Kconfig                               |  7 ++-
 drivers/mfd/rn5t618.c                             | 70 +++++++++++++++++++----
 drivers/regulator/Kconfig                         |  5 +-
 drivers/regulator/rn5t618-regulator.c             | 40 +++++++++++--
 include/linux/mfd/rn5t618.h                       | 13 +++++
 7 files changed, 126 insertions(+), 29 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

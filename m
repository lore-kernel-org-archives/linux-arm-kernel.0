From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Aug 2016 09:42:25 +0100
Subject: [GIT PULL] Immutable branch between MFD and GPIO due for v4.9
In-Reply-To: <1470814755-19447-1-git-send-email-patrice.chotard@st.com>
References: <1470814755-19447-1-git-send-email-patrice.chotard@st.com>
Message-ID: <20160810084225.GQ1581@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enjoy!

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-gpio-v4.9

for you to fetch changes up to c6a05a0563efd6cddafe4e8c857cf87d1311e83b:

  gpio: stmpe: Add STMPE1600 support (2016-08-10 09:25:26 +0100)

----------------------------------------------------------------
Immutable branch between MFD and GPIO due for the v4.9 merge window

----------------------------------------------------------------
Patrice Chotard (10):
      mfd: stmpe: Add STMPE_IDX_SYS_CTRL/2 enum
      mfd: stmpe: Add reset support for all STMPE variant
      gpio: stmpe: Fix edge and rising/falling edge detection
      gpio: stmpe: Write int status register only when needed
      mfd: stmpe: Use generic bit mask name
      mfd: stmpe: Rework registers access
      gpio: stmpe: Rework registers access
      Documentation: dt: Add stmpe1600 compatible string to STMPE MFD
      mfd: Add STMPE1600 support
      gpio: stmpe: Add STMPE1600 support

 Documentation/devicetree/bindings/mfd/stmpe.txt |   2 +-
 drivers/gpio/gpio-stmpe.c                       | 167 +++++++++++++++++-------
 drivers/mfd/stmpe-i2c.c                         |   2 +
 drivers/mfd/stmpe.c                             | 161 +++++++++++++++++++----
 drivers/mfd/stmpe.h                             |  85 ++++++++++--
 include/linux/mfd/stmpe.h                       |  21 +++
 6 files changed, 352 insertions(+), 86 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

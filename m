From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 15 May 2018 15:35:36 -0700
Subject: [GIT PULL] Amlogic defconfig updates for v4.18
Message-ID: <7h7eo4tumf.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-defconfig

for you to fetch changes up to 1e3e7a9f27dc73c50ad7b0f06e6e519bbaa3fee9:

  ARM: multi_v7_defconfig: enable the Meson PWM controller (2018-04-27 12:06:02 -0700)

----------------------------------------------------------------
Amlogic: defconfig updates for v4.18
- multi_v7_defconfig: enable meson PWM, I2C drivers

----------------------------------------------------------------
Martin Blumenstingl (2):
      arm: multi_v7_defconfig: enable the Amlogic Meson I2C driver
      ARM: multi_v7_defconfig: enable the Meson PWM controller

 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

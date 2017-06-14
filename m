From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 14 Jun 2017 10:46:13 -0700
Subject: [GIT PULL] Amlogic SoC updates for v4.13
Message-ID: <7h60fycviy.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-soc

for you to fetch changes up to 2dda2de5a1e1684aa4d31d0c2db42f6446a76a86:

  arm: meson: select the clock controller for Meson8 (2017-06-09 11:15:36 -0700)

----------------------------------------------------------------
Amlogic SoC updates for v4.13
- enable the clock controller for 32-bit Meson8

----------------------------------------------------------------
Martin Blumenstingl (1):
      arm: meson: select the clock controller for Meson8

 arch/arm/mach-meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

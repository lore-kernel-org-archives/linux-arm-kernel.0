From: olof@lixom.net (Olof Johansson)
Date: Mon,  8 May 2017 23:52:47 -0700
Subject: [GIT PULL 1/7] ARM: SoC non-urgent fixes for merge window
In-Reply-To: <1494312773-9790-1-git-send-email-olof@lixom.net>
References: <1494312773-9790-1-git-send-email-olof@lixom.net>
Message-ID: <1494312773-9790-2-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Smaller patches that didn't seem to find a home in other branches, and
low-priority fixes from late in the merge window. A number of these are
MAINTAINER updates, it seems.

Highlights:

* Maintainers:
- Remove Alexandre Courbot and Stephen Warren from Tegra maintainership,
add Jon Hunter
- Remove Stephen Warren and add Stefan Wahren to bcm2835
- Tweaks for file flagging for Marvell Dove

* Fixes:
- For two non-common-clk platform, handle clk_disable with NULL arg
- Remove redundant Kconfig select for Oxnas

----------------------------------------------------------------

The following changes since commit 2868b2513aa732a99ea4a0a6bf10dc93c1f3dac2:

  Merge tag 'linux-kselftest-4.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes-nc

for you to fetch changes up to c58ab5376a0f46fd3356786f4b146894df40f22b:

  Merge tag 'tegra-for-4.12-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into next/fixes-non-critical

----------------------------------------------------------------

Alexandre Courbot (1):
      MAINTAINERS: tegra: Remove self as maintainer

Arnd Bergmann (3):
      Merge tag 'oxnas-arm-soc-for-4.12' of https://github.com/OXNAS/linux into next/fixes-non-critical
      Merge tag 'mvebu-soc-4.12-1' of git://git.infradead.org/linux-mvebu into next/fixes-non-critical
      Merge tag 'arm-soc/for-4.12/maintainers' of http://github.com/Broadcom/stblinux into next/fixes-non-critical

Eric Anholt (1):
      MAINTAINERS: Add Stefan Wahren to bcm2835.

Florian Fainelli (1):
      Merge tag 'bcm2835-maintainers-next-2017-03-21' into maintainers/next

Geert Uytterhoeven (1):
      MAINTAINERS: Add file patterns for dove device tree bindings

Jon Mason (1):
      MAINTAINERS: Add Jon Mason to BCM5301X maintainers

Masahiro Yamada (3):
      ARM: oxnas: remove redundant select CPU_V6K
      ARM: w90x900: let clk_disable() return immediately if clk is NULL
      ARM: mmp: let clk_disable() return immediately if clk is NULL

Olof Johansson (1):
      Merge tag 'tegra-for-4.12-misc' of git://git.kernel.org/.../tegra/linux into next/fixes-non-critical

Stephen Warren (1):
      MAINTAINERS: remove swarren from bcm2835

Thierry Reding (1):
      MAINTAINERS: tegra: Replace Stephen with Jon


 MAINTAINERS                   | 8 +++++---
 arch/arm/mach-mmp/clock.c     | 3 +++
 arch/arm/mach-oxnas/Kconfig   | 1 -
 arch/arm/mach-w90x900/clock.c | 3 +++
 4 files changed, 11 insertions(+), 4 deletions(-)

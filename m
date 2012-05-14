From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 14 May 2012 11:20:16 -0600
Subject: [GIT PULL] ARM: tegra: dt2 branch
Message-ID: <1337016017-30537-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is some late device tree additions and cleanup for Tegra.

This branch is based on the merge of the following branches from the
Tegra repo, which are all already pulled into arm-soc:

for-3.5/tegra30-audio
for-3.5/usb-ulpi
for-3.5/dt
... which are all based on for-3.5/gpio-pinmux

----------------------------------------------------------------

The following changes since commit 4b7e870590f65f4e8bb3cdb7f382e1a9dd17dad5:

  Merge branch 'for-3.5/dt' into for-3.5/dt2-new

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git for-3.5/dt2

for you to fetch changes up to 2a5fdc9adde8476751b63a795e3d66ae2ee3979d:

  ARM: dt: tegra: invert status=disable vs status=okay

----------------------------------------------------------------

 arch/arm/boot/dts/tegra-cardhu.dts    |   77 +++++---
 arch/arm/boot/dts/tegra-harmony.dts   |  100 +++++-----
 arch/arm/boot/dts/tegra-paz00.dts     |  112 ++++++-----
 arch/arm/boot/dts/tegra-seaboard.dts  |  176 +++++++++--------
 arch/arm/boot/dts/tegra-trimslice.dts |   71 ++++---
 arch/arm/boot/dts/tegra-ventana.dts   |   90 +++++----
 arch/arm/boot/dts/tegra20.dtsi        |  275 ++++++++++++---------------
 arch/arm/boot/dts/tegra30.dtsi        |  292 ++++++++++++----------------
 8 files changed, 588 insertions(+), 605 deletions(-)

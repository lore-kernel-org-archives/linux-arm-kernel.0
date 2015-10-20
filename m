From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 20 Oct 2015 15:17:37 +0200
Subject: [GIT PULL 3/4] ARM: tegra: Devicetree changes for v4.4-rc1
In-Reply-To: <1445347058-8834-1-git-send-email-thierry.reding@gmail.com>
References: <1445347058-8834-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1445347058-8834-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.4-dt

for you to fetch changes up to 481b4f1a3f64c529333186a9e94eab41b271e3d8:

  ARM: tegra: Use consistent indentation for SATA node (2015-10-20 13:51:52 +0200)

----------------------------------------------------------------
ARM: tegra: Devicetree changes for v4.4-rc1

Mostly a bunch of updates to the Toradex Apalis and Colibri platforms
along with a couple of cleanup patches.

----------------------------------------------------------------
Jon Hunter (1):
      ARM: tegra: Enable CPUFreq support for Tegra124 Chromebooks

Marcel Ziswiler (21):
      ARM: tegra: Whitespace clean-up for Tegra20/30/124
      ARM: tegra: apalis: Update hardware revisions compatibility comment
      ARM: tegra: apalis: Fix HDMI power supplies
      ARM: tegra: apalis: Fix pin muxing
      ARM: tegra: apalis: Add comment concerning eMMC
      ARM: tegra: apalis: Add digital audio pin muxing
      ARM: tegra: apalis-eval: Enable HDA controller
      ARM: tegra: apalis-eval: Set OTG dr_mode
      ARM: tegra: apalis-eval: Fix backlight PWM comment
      ARM: tegra: apalis-eval: Fix power/wakeup key
      ARM: tegra: colibri: Update hardware revisions compatibility
      ARM: tegra: colibri: Fix HDMI supplies
      ARM: tegra: colibri: Improve comment about thermal alert pin
      ARM: tegra: colibri: Add pin muxing for on-module power I2C
      ARM: tegra: colibri: Fix comment about 3v3 fixed supply
      ARM: tegra: colibri: Add touch pen interrupt pin muxing
      ARM: tegra: colibri: Activate STMPE811 touch controller
      ARM: tegra: colibri: Replace eMMC label by comment
      ARM: tegra: colibri-eval: Fix vendor string of M41T0M6 RTC
      ARM: tegra: colibri-eval: Add comment concerning SD/MMC
      ARM: tegra: colibri-eval: Fix power/wakeup key

Thierry Reding (3):
      ARM: tegra: apalis: Properly align pin names
      ARM: tegra: colibri: Properly align pin names
      ARM: tegra: Use consistent indentation for SATA node

 arch/arm/boot/dts/tegra124-nyan.dtsi          |  15 +-
 arch/arm/boot/dts/tegra124.dtsi               |  20 +--
 arch/arm/boot/dts/tegra20.dtsi                |   4 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts     |  13 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi         | 214 ++++++++++++++++----------
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |   9 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi        | 196 ++++++++++++++++-------
 arch/arm/boot/dts/tegra30.dtsi                |  10 +-
 8 files changed, 315 insertions(+), 166 deletions(-)

From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 18 Aug 2013 21:48:04 +0800
Subject: [GIT PULL 1/5] ARM: imx: weim bus driver update for 3.12
Message-ID: <1376833688-24542-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:

  Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-weim-3.12

for you to fetch changes up to 3f98b6baad63b181da4e859d81953e88ce8a50ec:

  drivers: bus: imx-weim: Add support for i.MX1/21/25/27/31/35/50/51/53 (2013-08-16 12:59:44 +0800)

----------------------------------------------------------------
This is a patch series that updates imx-weim bus driver to have it
support more i.MX SoCs.  Because there is no maintainer for
drivers/bus so far, I'm forwarding it through IMX tree for 3.12 merge
window.

----------------------------------------------------------------
Alexander Shiyan (5):
      drivers: bus: imx-weim: Remove private driver data
      drivers: bus: imx-weim: Simplify error path
      drivers: bus: imx-weim: use module_platform_driver_probe()
      drivers: bus: imx-weim: Add missing platform_driver.owner field
      drivers: bus: imx-weim: Add support for i.MX1/21/25/27/31/35/50/51/53

 Documentation/devicetree/bindings/bus/imx-weim.txt |   17 ++-
 drivers/bus/Kconfig                                |    3 +-
 drivers/bus/imx-weim.c                             |  129 +++++++++++---------
 3 files changed, 87 insertions(+), 62 deletions(-)

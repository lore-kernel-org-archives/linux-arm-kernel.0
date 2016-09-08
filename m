From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 08 Sep 2016 16:08:45 +0200
Subject: [GIT PULL 1/3] Rockchip driver changes for 4.9
Message-ID: <1770547.rOXegfrGOH@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below a pull request for one lonely commit adding active-
wakeup functionality to the power-domain driver.

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.9-rockchip-drivers1

for you to fetch changes up to 6f27ab3e424a9532fd8e36c8732abb38eb0da993:

  soc: rockchip: support active_wakeup for rockchip power-domains (2016-08-19 00:37:20 +0200)

----------------------------------------------------------------
This enables the active-wakeup functionality of the generic power-domains
for the rockchip power-domain driver, so that some domains can stay
active during suspend.

----------------------------------------------------------------
Elaine Zhang (1):
      soc: rockchip: support active_wakeup for rockchip power-domains

 drivers/soc/rockchip/pm_domains.c | 100 ++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 43 deletions(-)

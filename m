From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 Oct 2013 03:21:39 -0700
Subject: [GIT PULL] ARM: SoC fixes for 3.12-rc
Message-ID: <20131025102139.GA27296@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 4d594dd3028ba8cdfcbd854bde3811a1ee4e36d7:

  ARM: exynos: dts: Update 5250 arch timer node with clock frequency (2013-10-13 09:33:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 08ddbb0a899a4e7a9214bc7c063be436cabbc52a:

  MAINTAINERS: Add maintainers entry for Rockchip SoCs (2013-10-18 07:01:00 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 3.12-rc

There's really only one bugfix in this branch, which is a fix for timers on
the integrator platform. Since Linus Walleij is resurrecting support for
the platform it seems valuable to get the fix into 3.12 even though the
regression has been around a while.

The rest are a handful of maintainers updates. If you prefer to hold those
until 3.13 then just merge the first patch on the branch which is the fix.

----------------------------------------------------------------
Heiko Stuebner (1):
      MAINTAINERS: Add maintainers entry for Rockchip SoCs

Jason Cooper (1):
      MAINTAINERS: ARM: mvebu: add Sebastian Hesselbarth

Linus Walleij (1):
      ARM: integrator: deactivate timer0 on the Integrator/CP

Stephen Warren (1):
      MAINTAINERS: Tegra updates, and driver ownership

 MAINTAINERS                        | 71 ++++++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/integratorcp.dts |  9 +++--
 2 files changed, 73 insertions(+), 7 deletions(-)

From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 17 Oct 2015 18:45:10 +0200
Subject: [GIT PULL 1/2] Rockchip drivers for 4.4 part 2
Message-ID: <4398388.V5gVWEu8o6@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

as the tag says, some fixes for the new power-domain driver, that turned
up since the origin al pull-req.


The following changes since commit 7c696693a4f54d12714738b45aee3e4302884ade:

  soc: rockchip: power-domain: Add power domain driver (2015-10-06 09:53:28 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.4-rockchip-drivers2

for you to fetch changes up to 4681347153dba01836aca18ebcfb4101c927d8ec:

  dt-bindings: Correct paths in Rockchip power domains binding document (2015-10-16 17:38:36 +0200)

----------------------------------------------------------------
Some fixes for the new power-domain driver, including restricting
Rockchip Kconfig options, fixing a possible null-pointer and a
typo in the dt-bindings.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      dt-bindings: Correct paths in Rockchip power domains binding document

Heiko Stuebner (1):
      soc: rockchip: power-domain: don't try to print the clock name in error case

Thierry Reding (1):
      soc: rockchip: Restrict to ARCH_ROCKCHIP

 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt | 4 ++--
 drivers/soc/rockchip/Kconfig                                    | 4 ++++
 drivers/soc/rockchip/pm_domains.c                               | 4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

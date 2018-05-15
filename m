From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 15 May 2018 12:38:09 +0200
Subject: [GIT PULL 1/4] Rockchip driver updates for 4.18 round 1
Message-ID: <2000491.bLgWuj0xar@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin Olof,

please find below and in the replies the main pull requests for Rockchip
stuff for 4.18. Depending on timing there may or may not be a second
round but so far I don't have anything big on the radar.

The signed tags should explain the individual contents, so please pull.


Thanks
Heiko


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.18-rockchip-drivers-1

for you to fetch changes up to 9e59c5f66c624b43c766a9fe3b2430e0e976bf0e:

  soc: rockchip: power-domain: Fix wrong value when power up pd with writemask (2018-05-14 11:53:26 +0200)

----------------------------------------------------------------
Fix for an issue introduced in 2016 where some powerdomains could only
be turned off but not on again.

----------------------------------------------------------------
Finley Xiao (1):
      soc: rockchip: power-domain: Fix wrong value when power up pd with writemask

 drivers/soc/rockchip/pm_domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

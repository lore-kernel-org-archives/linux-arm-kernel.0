From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 04 Mar 2016 02:39:50 +0100
Subject: [GIT PULL 1/3] 2nd part of rockchip soc-driver changes for 4.6
Message-ID: <2165258.7vUftGQ1I7@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

this contains a fix for the error handling of the power-domain driver.


Thanks
Heiko


The following changes since commit 1d961f11a108af9f7fbe89cc950a8d16ddbdbb28:

  soc: rockchip: power-domain: fix err handle while probing (2016-02-02 22:18:31 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.6-rockchip-drivers2

for you to fetch changes up to 1503cfbbc7c62509c9b1188508d312ab9c90cb24:

  soc: rockchip: power-domain: check the existing of regmap (2016-02-15 22:24:14 +0100)

----------------------------------------------------------------
Fix handling the case when syscon_node_to_regmap returns an error
in the power-domain driver.

----------------------------------------------------------------
Shawn Lin (1):
      soc: rockchip: power-domain: check the existing of regmap

 drivers/soc/rockchip/pm_domains.c | 4 ++++
 1 file changed, 4 insertions(+)

From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  1 Aug 2017 17:57:18 +0200
Subject: [PATCH 0/2] Few fix on armada-37xx pinctrl for v4.13
Message-ID: <20170801155720.10229-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

In v4.13-rc1 a regression appeared on Ethernet support on the Armada
3720 DB which occurred to be caused by a wrong configuration of the
pinctrl (due to obsolete documentation).

The first patch fix this issue, and the second one fix an other bug
found during the debug of the first one.

Please apply them for v4.13-rc.

Thanks,

Gregory

Gregory CLEMENT (2):
  pinctrl: armada-37xx: Fix the pin 23 on south bridge
  pinctrl: armada-37xx: Fix number of pin in south bridge

 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

-- 
2.13.2

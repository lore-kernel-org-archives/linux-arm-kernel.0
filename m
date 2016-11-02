From: clg@kaod.org (=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=)
Date: Wed,  2 Nov 2016 08:57:03 +0100
Subject: [PATCH 0/3] ipmi/bt-bmc: fix compatible node and add a request expiry
 list
Message-ID: <1478073426-3714-1-git-send-email-clg@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Corey,

Here is a short serie fixing the name of the device tree 'compatible'
node of the ipmi/bt-bmc driver and adding a request expiry list to the
driver.

The first patch should be considered as a 4.9 fix, if possible.

Thanks,

C.


C?dric Le Goater (3):
  ipmi/bt-bmc: change compatible node to 'aspeed,ast2400-ibt-bmc'
  ipmi/bt-bmc: maintain a request expiry list
  ipmi/bt-bmc: add a sysfs file to configure a maximum response time

 ...t2400-bt-bmc.txt => aspeed,ast2400-ibt-bmc.txt} |   4 +-
 drivers/char/ipmi/bt-bmc.c                         | 167 ++++++++++++++++++++-
 2 files changed, 167 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/ipmi/{aspeed,ast2400-bt-bmc.txt => aspeed,ast2400-ibt-bmc.txt} (85%)

-- 
2.7.4

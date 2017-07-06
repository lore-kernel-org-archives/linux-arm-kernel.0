From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu,  6 Jul 2017 22:28:20 +0800
Subject: [PATCH 0/2] Last step to working Allwinner R40 pinctrl
Message-ID: <20170706142822.20296-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains only two patches.

The first one is a minor fix for the A10 pinctrl driver, add a function
of a pin, which used to be missing in A10/A20 pinctrl driver.

The second one is the real R40 pinctrl part, with fixes suggested by
Chen-Yu.

Icenowy Zheng (2):
  pinctrl: sunxi: add a missing function of A10/A20 pinctrl driver
  pinctrl: sunxi: add support of R40 to A10 pinctrl driver

 drivers/pinctrl/sunxi/Kconfig             |   2 +-
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c | 281 +++++++++++++++++++++---------
 2 files changed, 204 insertions(+), 79 deletions(-)

-- 
2.13.0

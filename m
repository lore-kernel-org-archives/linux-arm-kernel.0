From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 22 Jul 2017 10:50:52 +0800
Subject: [PATCH v3 0/2] Last step to working Allwinner R40 pinctrl
Message-ID: <20170722025054.32645-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains only two patches.

The first one is a minor fix for the A10 pinctrl driver, add a function
of a pin, which used to be missing in A10/A20 pinctrl driver. Thanks for
Chen-Yu for discovering it when reviewing my R40 pinctrl patchset.

The second one is the real R40 pinctrl part, with fixes suggested by
Chen-Yu and Maxime.

Icenowy Zheng (2):
  pinctrl: sunxi: add a missing function of A10/A20 pinctrl driver
  pinctrl: sunxi: add support of R40 to A10 pinctrl driver

 drivers/pinctrl/sunxi/Kconfig             |   2 +-
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c | 274 +++++++++++++++++++++---------
 2 files changed, 197 insertions(+), 79 deletions(-)

-- 
2.13.0

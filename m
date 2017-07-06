From: finley.xiao@rock-chips.com (Finley Xiao)
Date: Thu,  6 Jul 2017 15:36:35 +0800
Subject: [PATCH 0/2] nvmem: rockchip-efuse: add support for rk3328-efuse
Message-ID: <1499326597-10821-1-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new property to define eFuse size and add the necessary data
for handling eFuse on the rk3328.

Finley Xiao (2):
  nvmem: rockchip-efuse: parse 'rockchip,efuse-size'
  nvmem: rockchip-efuse: add support for rk3328-efuse

 .../devicetree/bindings/nvmem/rockchip-efuse.txt   |  5 ++
 drivers/nvmem/rockchip-efuse.c                     | 70 +++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

-- 
2.7.4

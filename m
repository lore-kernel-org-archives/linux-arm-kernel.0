From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 13 Dec 2017 07:51:53 +0100
Subject: [PATCH v2 0/2] nvmem: efuse support for rk3328
Message-ID: <20171213065155.32020-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pretty similar to the other variants.

changes in v2:
- rebased on 4.15-rc2
- added Acks by Rob Herring
- increased udelay a tiny bit, due to infrequent read errors

Finley Xiao (2):
  nvmem: rockchip-efuse: parse 'rockchip,efuse-size'
  nvmem: rockchip-efuse: add support for rk3328-efuse

 .../devicetree/bindings/nvmem/rockchip-efuse.txt   |  5 ++
 drivers/nvmem/rockchip-efuse.c                     | 70 +++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

-- 
2.14.2

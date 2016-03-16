From: david.wu@rock-chips.com (David Wu)
Date: Thu, 17 Mar 2016 00:57:16 +0800
Subject: [PATCH v5 0/2] updates for rk3399 i2c support
Message-ID: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Wu (2):
  i2c: rk3x: switch to i2c generic dt parsing
  i2c: rk3x: add i2c support for rk3399 soc

 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  32 +-
 drivers/i2c/busses/i2c-rk3x.c                      | 524 ++++++++++++++++-----
 2 files changed, 440 insertions(+), 116 deletions(-)

-- 
1.9.1

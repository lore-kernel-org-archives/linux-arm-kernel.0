From: david.wu@rock-chips.com (David Wu)
Date: Thu, 22 Sep 2016 19:29:22 +0800
Subject: [PATCH 0/2] Fix warnings for i2c-rk3x.c
Message-ID: <1474543764-51135-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Wu (2):
  i2c: rk3x: Fix sparse warning
  i2c: rk3x: fix variable 'min_total_ns' unused warning

 drivers/i2c/busses/i2c-rk3x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
1.9.1

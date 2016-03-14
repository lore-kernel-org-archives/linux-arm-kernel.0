From: wdc@rock-chips.com (David Wu)
Date: Tue, 15 Mar 2016 06:52:27 +0800
Subject: [PATCH v4 0/3] update some i2c changes for rk3399 soc
Message-ID: <1457995950-46710-1-git-send-email-wdc@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Wu <david.wu@rock-chips.com>

David Wu (3):
  i2c: rk3x: switch to i2c generic dt parsing
  i2c: rk3x: add new method to caculate i2c timings for rk3399
  i2c: rk3x: support I2C Highspeed Mode for rk3399

 drivers/i2c/busses/i2c-rk3x.c | 473 ++++++++++++++++++++++++++++++++----------
 1 file changed, 364 insertions(+), 109 deletions(-)

-- 
1.9.1

From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 30 Aug 2011 11:46:07 -0600
Subject: [PATCH REPOST 0/3] i2c: tegra: Outstanding patches
Message-ID: <1314726370-8193-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For convenience, here's a repost of the outstanding patches for the Tegra
I2C driver.

Doug Anderson (1):
  i2c: tegra: fix possible race condition after tx

John Bonesio (1):
  i2c: Tegra: Add of_match_table

Mike Rapoport (1):
  i2c: i2c-tegra: add I2C_FUNC_SMBUS_EMUL

 drivers/i2c/busses/i2c-tegra.c |   60 ++++++++++++++++++++++++++++++----------
 1 files changed, 45 insertions(+), 15 deletions(-)

From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  7 Jun 2013 17:44:58 +0200
Subject: [PATCH 0/2] i2c-mv64xxx: Various fixes
Message-ID: <1370619900-15963-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series contains a real fix for the I2C controller of the Armada
XP SoC and a patch closer to a improvement than a fix.

They are independent and are only in the same series because they are
kind of fixes.

They are based on 3.10-rc4, and they will be small conflicts if they
are applied on top of i2c/for-next branch and on top of the series I
have just sent to add I2C Transaction Generator support. You can have
a look on the branch i2c-mv64xxx-fixes-bridge to get an idea on how to
resolve it. This branch is located at
https://github.com/MISL-EBU-System-SW/mainline-public.git

Thanks,

Zbigniew Bodek (2):
  i2c-mv64xxx: Fix timing issue on Armada XP (errata FE-8471889)
  i2c-mv64xxx: Abort the mv64xxx_of_config if clock-frequency is not
    provided

 drivers/i2c/busses/i2c-mv64xxx.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

-- 
1.8.1.2

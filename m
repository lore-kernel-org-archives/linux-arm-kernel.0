From: xuwei5@hisilicon.com (xuwei)
Date: Wed, 10 Sep 2014 17:01:30 +0800
Subject: [GIT PULL][for 3.18] pull request for the clock update of Hisilicon
 HiX5HD2 soc
Message-ID: <5410136A.4080701@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Please help to merge pull request for the clock update of Hisilicon HiX5HD2 soc. 

Best Regards,
Wei

The following changes since commit 5162797e4d77414cd9ac863ca58588c10b8f8f3a:

  clk: hix5hd2: add complex clk (2014-09-01 16:09:05 +0100)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hix5hd2-clock-for-3.18

for you to fetch changes up to b89ffd8e390a9f0812e62c4985b6d3f246669273:

  clk: hix5hd2: add I2C clocks (2014-09-01 16:09:33 +0100)

----------------------------------------------------------------
Hisilicon HiX5HD2 clock updates for 3.18

-Add I2C, watchdog and sd clocks
-Add clock drivers for HiX5HD2 to support sata, usb and ethernet

----------------------------------------------------------------
Guoxiong Yan (1):
      clk: hix5hd2: add watchdog0 clocks

Jiancheng Xue (1):
      clk: hix5hd2: add sd clk

Wei Yan (1):
      clk: hix5hd2: add I2C clocks

 drivers/clk/hisilicon/clk-hix5hd2.c       | 51 +++++++++++++++++++++++++++++++++++++++++++++------
 include/dt-bindings/clock/hix5hd2-clock.h | 18 ++++++++++++++++++
 2 files changed, 63 insertions(+), 6 deletions(-)

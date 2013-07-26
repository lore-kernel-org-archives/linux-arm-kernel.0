From: nv-dung@jinso.co.jp (Nguyen Viet Dung)
Date: Fri, 26 Jul 2013 19:33:38 +0900
Subject: [PATCH v2 0/1 resend] ARM: shmobile: r8a7790: add I2C support
Message-ID: <1374834819-319-1-git-send-email-nv-dung@jinso.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram
CC Morimoto

Please consider the following patch for the r8a7790 Soc.
This patch modify I2C driver of rcar-H1 to usable on both rcar-H1 and rcar-H2.
It was developed base on the renesas-next-20130528 branch and 
have tested on the Lager board.
Input clock of I2C is peripheral module clock that is named peripheral_clk.

V2: dropped patches 2,3,4 from the previous version.

Thanks,
Nguyen viet Dung

Nguyen Viet Dung (1):
  i2c: rcar: modify I2C driver

 drivers/i2c/busses/i2c-rcar.c |   17 +++++++++++++++--
 include/linux/i2c/i2c-rcar.h  |    4 ++++
 2 files changed, 19 insertions(+), 2 deletions(-)

-- 
1.7.9.5

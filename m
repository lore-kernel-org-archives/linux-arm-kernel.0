From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Jun 2017 14:29:50 +0200
Subject: [PATCH 0/2] Couple of fixes for pinctrl-armada-37xx
Message-ID: <20170623122952.9871-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Ken Ma found few issues in the driver. I wrote the first fix is based
on his report and the second one was written for U-Boot but as they
use the same driver it can be applied on linux too.

thanks,

Gregory

Gregory CLEMENT (1):
  pinctrl: armada-37xx: Fix number of pin in sdio_sb

Ken Ma (1):
  pinctrl: armada-37xx: Fix uart2 group selection register mask

 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.11.0

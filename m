From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 4 Dec 2015 21:56:59 +0800
Subject: [PATCH 0/2] phy: berlin-usb: clean up
Message-ID: <1449237421-5552-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

trivial patches to do some clean up: remove non-necessary header files
and remove useless platform_set_drvdata() calling.

Jisheng Zhang (2):
  phy: berlin-usb: remove non-necessary header files
  phy: berlin-usb: don't set device's driver_data

 drivers/phy/phy-berlin-usb.c | 3 ---
 1 file changed, 3 deletions(-)

-- 
2.6.2

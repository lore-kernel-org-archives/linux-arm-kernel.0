From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 19 Jan 2015 00:15:52 +0800
Subject: [PATCH v1 0/1] thermal: rockchip: make temperature reporting much
 more accurate
Message-ID: <1421597753-2082-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch is merged on chromiumos/third_party/kernel.
https://chromium-review.googlesource.com/#/c/239190/

Tested on veyron boards.



Caesar Wang (1):
  thermal: rockchip: make temperature reporting much more accurate

 drivers/thermal/rockchip_thermal.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

-- 
1.9.1

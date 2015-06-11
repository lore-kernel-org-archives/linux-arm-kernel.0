From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 11 Jun 2015 11:16:31 +0200
Subject: [PATCH 0/1] i2c: at91: fix code checker warnings
Message-ID: <cover.1434013494.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ChangeLog

v1:
This patch fixes somes code checker warnings reported by Wolfram Sang:

drivers/i2c/busses/i2c-at91.c:213: style: Checking if unsigned variable 'buf_len' is less than zero.
drivers/i2c/busses/i2c-at91.c:254: style: Checking if unsigned variable 'buf_len' is less than zero.
drivers/i2c/busses/i2c-at91.c:293: style: Checking if unsigned variable 'buf_len' is less than zero.

Thanks for reporting!

Cyrille Pitchen (1):
  i2c: at91: fix code checker warnings

 drivers/i2c/busses/i2c-at91.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.2.2

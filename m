From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 2 Feb 2018 18:20:06 +0100
Subject: [PATCH 0/2] I2C-DaVinci: Adjustments for davinci_i2c_probe()
Message-ID: <4e668c87-65f5-8a00-132a-0184779faa08@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 18:16:14 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/i2c/busses/i2c-davinci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.16.1

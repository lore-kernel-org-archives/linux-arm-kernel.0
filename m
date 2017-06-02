From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Fri,  2 Jun 2017 18:52:37 -0500
Subject: [PATCHv3 2/4] MAINTAINERS: Add Altera I2C Controller Driver
In-Reply-To: <1496447559-19782-1-git-send-email-thor.thayer@linux.intel.com>
References: <1496447559-19782-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1496447559-19782-3-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add maintainer for the Altera I2C Controller Driver.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2&3  No change
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9609ca6..86053d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -636,6 +636,11 @@ ALPS PS/2 TOUCHPAD DRIVER
 R:	Pali Roh?r <pali.rohar@gmail.com>
 F:	drivers/input/mouse/alps.*
 
+ALTERA I2C CONTROLLER DRIVER
+M:	Thor Thayer <thor.thayer@linux.intel.com>
+S:	Maintained
+F:	drivers/i2c/busses/i2c-altera.c
+
 ALTERA MAILBOX DRIVER
 M:	Ley Foon Tan <lftan@altera.com>
 L:	nios2-dev at lists.rocketboards.org (moderated for non-subscribers)
-- 
2.7.4

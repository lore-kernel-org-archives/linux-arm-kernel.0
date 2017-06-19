From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Mon, 19 Jun 2017 15:36:56 -0500
Subject: [PATCHv4 1/3] MAINTAINERS: Add Altera I2C Controller Driver
In-Reply-To: <1497904618-27010-1-git-send-email-thor.thayer@linux.intel.com>
References: <1497904618-27010-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1497904618-27010-2-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add maintainer for the Altera I2C Controller Driver.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2-4  No change
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ced1383..c00af95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -636,6 +636,11 @@ ALPS PS/2 TOUCHPAD DRIVER
 R:	Pali Roh??r <pali.rohar@gmail.com>
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

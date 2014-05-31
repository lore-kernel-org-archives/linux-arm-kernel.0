From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 31 May 2014 10:01:34 +0400
Subject: [PATCH 3/3] ARM: i.MX: avic: Cleanup driver
In-Reply-To: <1401516095-31020-1-git-send-email-shc_work@mail.ru>
References: <1401516095-31020-1-git-send-email-shc_work@mail.ru>
Message-ID: <1401516095-31020-5-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reduce license text and removes unused #include.
No functional changes.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/avic.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index 374be0c..d020531 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -6,18 +6,8 @@
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version 2
  * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA  02110-1301, USA.
  */
 
-#include <linux/module.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
@@ -27,7 +17,6 @@
 #include <asm/exception.h>
 
 #include "common.h"
-#include "hardware.h"
 #include "irq-common.h"
 
 #define AVIC_INTCNTL		0x00	/* int control reg */
-- 
1.8.5.5

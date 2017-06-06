From: guodong.xu@linaro.org (Guodong Xu)
Date: Tue,  6 Jun 2017 16:51:36 +0800
Subject: [PATCH v4 1/8] mfd: hi6421-pmic: cleanup: change license text to
 shorter form
In-Reply-To: <20170606085143.13154-1-guodong.xu@linaro.org>
References: <20170606085143.13154-1-guodong.xu@linaro.org>
Message-ID: <20170606085143.13154-2-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change license text to a shorter form of GPLv2.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/mfd/hi6421-pmic-core.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/hi6421-pmic-core.c b/drivers/mfd/hi6421-pmic-core.c
index 3fd703f..ad9e3d8 100644
--- a/drivers/mfd/hi6421-pmic-core.c
+++ b/drivers/mfd/hi6421-pmic-core.c
@@ -9,17 +9,8 @@
  * Author: Guodong Xu <guodong.xu@linaro.org>
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 
 #include <linux/device.h>
-- 
2.10.2

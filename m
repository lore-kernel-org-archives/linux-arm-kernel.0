From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 12:11:25 +0100
Subject: [PATCH 19/19] mfd: wm8997-tables: Suppress 'line over 80 chars'
 warnings
In-Reply-To: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406027485-15657-20-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of an effort to clean-up the MFD subsystem.

WARNING: line over 80 characters
+       { 0x00000068, 0x01FF },    /* R104   - Always On Triggers Sequence Select 3 */

WARNING: line over 80 characters
+       { 0x00000069, 0x01FF },    /* R105   - Always On Triggers Sequence Select 4 */

WARNING: line over 80 characters
+       { 0x0000006A, 0x01FF },    /* R106   - Always On Triggers Sequence Select 5 */

WARNING: line over 80 characters
+       { 0x0000006B, 0x01FF },    /* R107   - Always On Triggers Sequence Select 6 */

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/wm8997-tables.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/wm8997-tables.c b/drivers/mfd/wm8997-tables.c
index c7a81da..04bc6d5 100644
--- a/drivers/mfd/wm8997-tables.c
+++ b/drivers/mfd/wm8997-tables.c
@@ -174,10 +174,10 @@ static const struct reg_default wm8997_reg_default[] = {
 	{ 0x00000062, 0x01FF },    /* R98    - Sample Rate Sequence Select 2 */
 	{ 0x00000063, 0x01FF },    /* R99    - Sample Rate Sequence Select 3 */
 	{ 0x00000064, 0x01FF },    /* R100   - Sample Rate Sequence Select 4 */
-	{ 0x00000068, 0x01FF },    /* R104   - Always On Triggers Sequence Select 3 */
-	{ 0x00000069, 0x01FF },    /* R105   - Always On Triggers Sequence Select 4 */
-	{ 0x0000006A, 0x01FF },    /* R106   - Always On Triggers Sequence Select 5 */
-	{ 0x0000006B, 0x01FF },    /* R107   - Always On Triggers Sequence Select 6 */
+	{ 0x00000068, 0x01FF },    /* R104   - AlwaysOn Triggers Seq Select 3 */
+	{ 0x00000069, 0x01FF },    /* R105   - AlwaysOn Triggers Seq Select 4 */
+	{ 0x0000006A, 0x01FF },    /* R106   - AlwaysOn Triggers Seq Select 5 */
+	{ 0x0000006B, 0x01FF },    /* R107   - AlwaysOn Triggers Seq Select 6 */
 	{ 0x00000070, 0x0000 },    /* R112   - Comfort Noise Generator */
 	{ 0x00000090, 0x0000 },    /* R144   - Haptics Control 1 */
 	{ 0x00000091, 0x7FFF },    /* R145   - Haptics Control 2 */
-- 
1.8.3.2

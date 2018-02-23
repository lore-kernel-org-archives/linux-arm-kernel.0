From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 23 Feb 2018 17:11:50 +0530
Subject: [PATCH] firmware: ti_sci: Switch to SPDX Licensing
Message-ID: <20180223114150.9980-1-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to SPDX licensing and drop the GPL text which comes redundant.

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/firmware/ti_sci.c              | 10 +---------
 drivers/firmware/ti_sci.h              | 30 +-----------------------------
 include/linux/soc/ti/ti_sci_protocol.h | 10 +---------
 3 files changed, 3 insertions(+), 47 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 5229036dcfbf..b74a533ef35b 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Texas Instruments System Control Interface Protocol Driver
  *
  * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
  *	Nishanth Menon
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #define pr_fmt(fmt) "%s: " fmt, __func__
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 9b611e9e6f6d..12bf316b68df 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: BSD-3-Clause
 /*
  * Texas Instruments System Control Interface (TISCI) Protocol
  *
@@ -6,35 +7,6 @@
  * See: http://processors.wiki.ti.com/index.php/TISCI for details
  *
  * Copyright (C)  2015-2016 Texas Instruments Incorporated - http://www.ti.com/
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *   Redistributions of source code must retain the above copyright
- *   notice, this list of conditions and the following disclaimer.
- *
- *   Redistributions in binary form must reproduce the above copyright
- *   notice, this list of conditions and the following disclaimer in the
- *   documentation and/or other materials provided with the
- *   distribution.
- *
- *   Neither the name of Texas Instruments Incorporated nor the names of
- *   its contributors may be used to endorse or promote products derived
- *   from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
  */
 
 #ifndef __TI_SCI_H
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 0ccbc138c26a..18435e5c6364 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Texas Instruments System Control Interface Protocol
  *
  * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
  *	Nishanth Menon
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __TISCI_PROTOCOL_H
-- 
2.16.1

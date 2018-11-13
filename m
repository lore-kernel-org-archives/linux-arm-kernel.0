From: andrealmeid@riseup.net (andrealmeid at riseup.net)
Date: Tue, 13 Nov 2018 16:58:35 -0200
Subject: [PATCH v3 2/2] stagin: vchi: Add SPDX-License-Identifier
In-Reply-To: <20181113185835.14429-1-andrealmeid@riseup.net>
References: <20181113185835.14429-1-andrealmeid@riseup.net>
Message-ID: <20181113185835.14429-3-andrealmeid@riseup.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andr? Almeida <andrealmeid@riseup.net>

Using multiple license representation as shown here [1].
[1] https://spdx.org/sites/cpstandard/files/pages/files/using_spdx_license_list_short_identifiers.pdf

Signed-off-by: Andr? Almeida <andrealmeid@riseup.net>

---

Thanks for the feedback Stefan. I've tried to make the code similar
to your example. Let me know if it's still wrong.
---
 .../vc04_services/interface/vchi/vchi_mh.h    | 30 +------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_mh.h b/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
index 40c760d493a1..bbf227e4f21a 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
@@ -1,34 +1,6 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0) */
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The names of the above-listed copyright holders may not be used
- *    to endorse or promote products derived from this software without
- *    specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") version 2, as published by the Free
- * Software Foundation.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
- * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
- * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
- * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
- * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
- * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
- * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
- * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 #ifndef VCHI_MH_H_
-- 
2.19.1

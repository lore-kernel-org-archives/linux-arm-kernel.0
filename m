From: andrealmeid@riseup.net (andrealmeid at riseup.net)
Date: Mon, 12 Nov 2018 22:37:33 -0200
Subject: [PATCH v2 2/2] stagin: vchi: Add SPDX-License-Identifier
In-Reply-To: <20181113003733.9615-1-andrealmeid@riseup.net>
References: <20181113003733.9615-1-andrealmeid@riseup.net>
Message-ID: <20181113003733.9615-3-andrealmeid@riseup.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andr? Almeida <andrealmeid@riseup.net>

As pointed by Stefan Wahren in v1, this file is dual licensed
as GPL-2 and BSD-3.

Using multiple license representation as shown here [1].

[1] https://spdx.org/sites/cpstandard/files/pages/files/using_spdx_license_list_short_identifiers.pdf

Signed-off-by: Andr? Almeida <andrealmeid@riseup.net>

---

 drivers/staging/vc04_services/interface/vchi/vchi_mh.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_mh.h b/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
index 40c760d493a1..5c780ec49ff7 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0) */
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
-- 
2.19.1

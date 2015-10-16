From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 16 Oct 2015 12:04:04 -0700
Subject: [PATCH] PCI: iproc: Fix company name
Message-ID: <1445022248-12203-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header of pcie-iproc.c contains an obvious typo on Broadcom
Corporation, fix that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/host/pcie-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index fe2efb141a9b..6c3d4b54858c 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2014 Hauke Mehrtens <hauke@hauke-m.de>
- * Copyright (C) 2015 Broadcom Corporatcommon ion
+ * Copyright (C) 2015 Broadcom Corporation
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
-- 
2.1.0

From: b.galvani@gmail.com (Beniamino Galvani)
Date: Thu,  1 May 2014 21:50:34 +0200
Subject: [PATCH 1/2] of: add bq and radxa vendor prefixes
Message-ID: <1398973835-26303-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new vendor prefixes for:

    * bq, a company that sells multimedia devices and 3D printers
    * Radxa, manufacturer of ARM boards

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index abc3080..6f8177c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -21,6 +21,7 @@ atmel	Atmel Corporation
 auo	AU Optronics Corporation
 avago	Avago Technologies
 bosch	Bosch Sensortec GmbH
+bq	bq
 brcm	Broadcom Corporation
 buffalo	Buffalo, Inc.
 calxeda	Calxeda
@@ -98,6 +99,7 @@ powervr	PowerVR (deprecated, use img)
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm Technologies, Inc
 qnap	QNAP Systems, Inc.
+radxa	Radxa
 raidsonic	RaidSonic Technology GmbH
 ralink	Mediatek/Ralink Technology Corp.
 ramtron	Ramtron International
-- 
1.7.10.4

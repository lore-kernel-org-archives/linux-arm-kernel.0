From: b.galvani@gmail.com (Beniamino Galvani)
Date: Tue,  6 May 2014 19:10:10 +0200
Subject: [PATCH v2 1/2] of: add mundoreader and radxa vendor prefixes
Message-ID: <1399396211-25353-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new vendor prefixes for:

    * Mundo Reader S.L., a company that produces tablets and e-readers
    * Radxa, manufacturer of ARM boards

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---

v2:
 - use mundoreader prefix instead of bq as suggested by Heiko Stuebner

 Documentation/devicetree/bindings/vendor-prefixes.txt |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index abc3080..53bd92f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -79,6 +79,7 @@ microchip	Microchip Technology Inc.
 mosaixtech	Mosaix Technologies, Inc.
 moxa	Moxa
 mpl	MPL AG
+mundoreader	Mundo Reader S.L.
 mxicy	Macronix International Co., Ltd.
 national	National Semiconductor
 neonode		Neonode Inc.
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

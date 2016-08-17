From: ccc94453@vip.cybercity.dk (Rask Ingemann Lambertsen)
Date: Wed, 17 Aug 2016 23:32:22 +0200
Subject: [PATCH v3 2/3] devicetree: Add vendor prefix for Shenzhen Sunchip
 Technology Co., Ltd
In-Reply-To: <54da74da3f60ede0bf8fb789ffee584703e81a29.1471553094.git.ccc94453@vip.cybercity.dk>
References: <54da74da3f60ede0bf8fb789ffee584703e81a29.1471553094.git.ccc94453@vip.cybercity.dk>
Message-ID: <8657d95d89daa3836d30ca390c49fb92eb263b16.1471553094.git.ccc94453@vip.cybercity.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shenzhen Sunchip Technology Co., Ltd produces TV boxes and TV dongles,
some of which are sold under other brands. Website:
<URL:http://www.sunchip-tech.com/>

Signed-off-by: Rask Ingemann Lambertsen <ccc94453@vip.cybercity.dk>
---

Changes in v3:
None.

Changes in v2:
No patch changes, but added CC to the ARM kernel mailing list.

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 69398cf..2ec157c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -254,6 +254,7 @@ starry	Starry Electronic Technology (ShenZhen) Co., LTD
 startek	Startek
 ste	ST-Ericsson
 stericsson	ST-Ericsson
+sunchip	Shenzhen Sunchip Technology Co., Ltd
 SUNW	Sun Microsystems, Inc
 syna	Synaptics Inc.
 synology	Synology, Inc.
-- 
2.8.1

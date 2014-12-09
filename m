From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  9 Dec 2014 12:25:04 +0100
Subject: [PATCH 6/7] ARM: shmobile: alt dts: Replace status value "ok" by
 "okay"
In-Reply-To: <1418124305-7445-1-git-send-email-geert+renesas@glider.be>
References: <1418124305-7445-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1418124305-7445-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While the DT parsing code recognizes "ok" as a valid value for the
"status" property, ePAPR v1.1 doesn't mention it in the list of valid
values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index f2cf7576bf3f5a0b..0d848e60507172ef 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -40,9 +40,9 @@
 };
 
 &cmt0 {
-	status = "ok";
+	status = "okay";
 };
 
 &scif2 {
-	status = "ok";
+	status = "okay";
 };
-- 
1.9.1

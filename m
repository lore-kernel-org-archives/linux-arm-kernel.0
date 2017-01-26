From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 26 Jan 2017 23:48:55 +0800
Subject: [PATCH v2 5/9] clk: sunxi-ng: remove transitional headers for
 dt-bindings
In-Reply-To: <20170126154859.55855-1-icenowy@aosc.xyz>
References: <20170126154859.55855-1-icenowy@aosc.xyz>
Message-ID: <20170126154859.55855-6-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have already changed the DTSI file, the trnasitional dt-bindings
header sun8i-h3-ccu.h will not be needed any more.

Remove them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
New patch.
To maintain the bisectbility on the kernel source tree, PATCH 3/7 imports
two header symlinks, to satisfy sun8i-h3.dtsi.
As sun8i-h3.dtsi is changed now, the trasitional header files are now not
needed.

 include/dt-bindings/clock/sun8i-h3-ccu.h | 1 -
 include/dt-bindings/reset/sun8i-h3-ccu.h | 1 -
 2 files changed, 2 deletions(-)
 delete mode 120000 include/dt-bindings/clock/sun8i-h3-ccu.h
 delete mode 120000 include/dt-bindings/reset/sun8i-h3-ccu.h

diff --git a/include/dt-bindings/clock/sun8i-h3-ccu.h b/include/dt-bindings/clock/sun8i-h3-ccu.h
deleted file mode 120000
index ef38232141e4..000000000000
--- a/include/dt-bindings/clock/sun8i-h3-ccu.h
+++ /dev/null
@@ -1 +0,0 @@
-sunxi-h3-h5-ccu.h
\ No newline at end of file
diff --git a/include/dt-bindings/reset/sun8i-h3-ccu.h b/include/dt-bindings/reset/sun8i-h3-ccu.h
deleted file mode 120000
index ef38232141e4..000000000000
--- a/include/dt-bindings/reset/sun8i-h3-ccu.h
+++ /dev/null
@@ -1 +0,0 @@
-sunxi-h3-h5-ccu.h
\ No newline at end of file
-- 
2.11.0

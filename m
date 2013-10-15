From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 15 Oct 2013 17:52:46 +0300
Subject: [PATCH v3 01/19] ARM: tegra30: add missing CLK IDs
In-Reply-To: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
References: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1381848794-11761-2-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra30 clock bindings lack few IDs for audio and clk_out muxes.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 include/dt-bindings/clock/tegra30-car.h |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/include/dt-bindings/clock/tegra30-car.h b/include/dt-bindings/clock/tegra30-car.h
index e40fae8..2244582 100644
--- a/include/dt-bindings/clock/tegra30-car.h
+++ b/include/dt-bindings/clock/tegra30-car.h
@@ -260,6 +260,14 @@
 /* 298 */
 /* 299 */
 #define TEGRA30_CLK_CLK_OUT_1_MUX 300
-#define TEGRA30_CLK_CLK_MAX 301
+#define TEGRA30_CLK_CLK_OUT_2_MUX 301
+#define TEGRA30_CLK_CLK_OUT_3_MUX 302
+#define TEGRA30_CLK_AUDIO0_MUX 303
+#define TEGRA30_CLK_AUDIO1_MUX 304
+#define TEGRA30_CLK_AUDIO2_MUX 305
+#define TEGRA30_CLK_AUDIO3_MUX 306
+#define TEGRA30_CLK_AUDIO4_MUX 307
+#define TEGRA30_CLK_SPDIF_MUX 308
+#define TEGRA30_CLK_CLK_MAX 309
 
 #endif	/* _DT_BINDINGS_CLOCK_TEGRA30_CAR_H */
-- 
1.7.7.rc0.72.g4b5ea.dirty

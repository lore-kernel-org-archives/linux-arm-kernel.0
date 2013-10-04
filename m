From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 4 Oct 2013 12:12:42 +0300
Subject: [PATCH 3/5] clk: tegra124: Add common clk IDs to clk-id.h
In-Reply-To: <1380878014-22088-1-git-send-email-pdeschrijver@nvidia.com>
References: <1380878014-22088-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1380878014-22088-4-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra124 introduces a number of a new clocks. Introduce the corresponding
the IDs for them.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-id.h |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/tegra/clk-id.h b/drivers/clk/tegra/clk-id.h
index b2a4d45..4ac3017 100644
--- a/drivers/clk/tegra/clk-id.h
+++ b/drivers/clk/tegra/clk-id.h
@@ -191,6 +191,33 @@ enum clk_id {
 	tegra_clk_clk_out_3_mux,
 	tegra_clk_dsia_mux,
 	tegra_clk_dsib_mux,
+
+	tegra124_clk_isp,
+	tegra_clk_uarte,
+	tegra_clk_entropy,
+	tegra_clk_i2c6,
+	tegra_clk_hdmi_audio,
+	tegra_clk_clk72Mhz,
+	tegra_clk_vic03,
+	tegra_clk_adx1,
+	tegra_clk_amx1,
+	tegra_clk_sor0,
+	tegra_clk_sata_oob,
+	tegra_clk_sata,
+	tegra_clk_vi_sensor2,
+	tegra_clk_ispb,
+	tegra_clk_vim2_clk,
+	tegra_clk_pcie,
+	tegra_clk_afi,
+	tegra_clk_sata_cold,
+	tegra_clk_dpaux,
+	tegra_clk_gpu,
+	tegra_clk_pll_p_out5,
+	tegra_clk_cml0,
+	tegra_clk_cml1,
+	tegra_clk_pll_c4,
+	tegra_clk_pll_dp,
+
 	tegra_clk_max,
 };
 
-- 
1.7.7.rc0.72.g4b5ea.dirty

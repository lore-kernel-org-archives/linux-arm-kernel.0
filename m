From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Fri, 13 Jul 2012 17:51:04 +0530
Subject: [PATCH 1/3] ARM: SPEAr3xx: Rename gpt timer clk parent name
In-Reply-To: <cover.1342181727.git.vipulkumar.samar@st.com>
References: <cover.1342181727.git.vipulkumar.samar@st.com>
Message-ID: <0275d6ccd52ace2ce8ac87f159df89ae746e82a5.1342181727.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As pll3_48m_clk clock is renamed like pll3_clk so make corresponding changes for
gpt parent clock name.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 arch/arm/mach-spear3xx/spear3xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 0f41bd1..66db5f1 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -87,7 +87,7 @@ void __init spear3xx_map_io(void)
 
 static void __init spear3xx_timer_init(void)
 {
-	char pclk_name[] = "pll3_48m_clk";
+	char pclk_name[] = "pll3_clk";
 	struct clk *gpt_clk, *pclk;
 
 	spear3xx_clk_init();
-- 
1.7.2.2

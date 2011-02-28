From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 28 Feb 2011 16:11:16 +0530
Subject: [PATCH 1/8 resend] dw_dmac: Remove compilation dependency from AVR32
In-Reply-To: <cover.1298889267.git.viresh.kumar@st.com>
References: <cover.1298889267.git.viresh.kumar@st.com>
Message-ID: <d41145ce4d5e3d870f720709f68d5b1dbf34d6a0.1298889267.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used in SPEAr, ARM family.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 1c28816..95c7db7 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -82,7 +82,6 @@ config INTEL_IOP_ADMA
 
 config DW_DMAC
 	tristate "Synopsys DesignWare AHB DMA support"
-	depends on AVR32
 	select DMA_ENGINE
 	default y if CPU_AT32AP7000
 	help
-- 
1.7.2.2

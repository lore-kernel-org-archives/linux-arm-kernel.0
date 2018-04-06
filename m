From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 6 Apr 2018 08:39:27 +0200
Subject: [PATCH 0/6] stm32mp1 clock update
Message-ID: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch-set adds minor corrections
- sparse corections
- add tzc2 missing clock
- remove unused constant
- fix SAI3 & SAI4 clocks
- set stgen_k clock as critical
- remove not useful ck_apb_dbg clock

Gabriel Fernandez (6):
  clk: stm32mp1: add missing static
  clk: stm32mp1: remove unused dfsdm_src[] const
  clk: stm32mp1: fix SAI3 & SAI4 clocks
  clk: stm32mp1: add missing tzc2 clock
  clk: stm32mp1: set stgen_k clock as critical
  clk: stm32mp1: remove unuseless ck_apb_dbg clock

 drivers/clk/clk-stm32mp1.c                | 54 +++++++++++++------------------
 include/dt-bindings/clock/stm32mp1-clks.h |  4 +--
 2 files changed, 25 insertions(+), 33 deletions(-)

-- 
1.9.1

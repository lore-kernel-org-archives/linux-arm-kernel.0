From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Wed, 15 Mar 2017 15:27:49 +0100
Subject: [PATCH 0/2] STM32F4 clock fixes
Message-ID: <1489588071-18164-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch-set contains 2 fixes.
One concerning exclusion of wrong values for PLLQ (0 & 1)
And the second is a fix about timeout management of PLL and LSE/LSI clocks.

Gabriel Fernandez (2):
  clk: stm32f4: fix: exclude values 0 and 1 for PLLQ
  clk: stm32f4: fix timeout management for pll and ready gate

 drivers/clk/clk-stm32f4.c | 56 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 17 deletions(-)

-- 
1.9.1

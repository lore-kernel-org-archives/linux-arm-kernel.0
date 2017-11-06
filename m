From: olivier.moysan@st.com (Olivier Moysan)
Date: Mon, 6 Nov 2017 16:18:51 +0100
Subject: [PATCH 0/2] ASoC: stm32: spdifrx: DMA management fixes
Message-ID: <1509981533-28622-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set gathers DMA management fixes for STM32 SPDIFRX.

Olivier Moysan (2):
  ASoC: stm32: spdifrx: fix 16 bits capture
  ASoC: stm32: spdifrx: fix control DMA error management

 sound/soc/stm/stm32_spdifrx.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
1.9.1

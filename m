From: olivier.moysan@st.com (olivier moysan)
Date: Fri, 16 Jun 2017 14:16:22 +0200
Subject: [PATCH 0/2] ASoC: stm32: sai: Add H7 support
Message-ID: <1497615384-7407-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set adds support of the Serial Audio Interface (SAI) IP on H7 STM32 platform family.

olivier moysan (2):
  dt-bindings: stm32: add h7 support for sai
  ASoC: stm32: sai: add h7 support

 .../devicetree/bindings/sound/st,stm32-sai.txt     | 18 ++---
 sound/soc/stm/stm32_sai.c                          | 13 ++-
 sound/soc/stm/stm32_sai.h                          | 72 +++++++++++++++--
 sound/soc/stm/stm32_sai_sub.c                      | 92 ++++++++++++++++++----
 4 files changed, 164 insertions(+), 31 deletions(-)

-- 
1.9.1

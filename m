From: olivier.moysan@st.com (olivier moysan)
Date: Fri, 16 Jun 2017 14:15:27 +0200
Subject: [PATCH 0/7] ASoC: stm32: sai: misc fixes
Message-ID: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set gathers various fixes on STM32 SAI driver.

olivier moysan (7):
  dt-bindings: stm32: sai: fix DT example
  ASoC: stm32: change SAI configuration flag
  ASoC: stm32: sai: typo fixes
  ASoC: stm32: sai: remove spurious trace
  ASoC: stm32: sai: change stop sequence
  ASoC: stm32: sai: fix clock management
  ASoC: stm32: sai: manage master clock

 .../devicetree/bindings/sound/st,stm32-sai.txt     | 25 ++++------
 sound/soc/stm/Kconfig                              | 10 ++--
 sound/soc/stm/Makefile                             |  4 +-
 sound/soc/stm/stm32_sai.c                          |  2 +-
 sound/soc/stm/stm32_sai.h                          |  1 -
 sound/soc/stm/stm32_sai_sub.c                      | 57 +++++++++++++---------
 6 files changed, 54 insertions(+), 45 deletions(-)

-- 
1.9.1

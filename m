From: ludovic.Barre@st.com (Ludovic Barre)
Date: Tue, 17 Jul 2018 11:56:25 +0200
Subject: [PATCH 0/2] add syscfg mask parameter
Message-ID: <1531821387-29845-1-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series adds mask parameter to define IRQ mux field.
This field could vary depend of IRQ mux selection register.
This parameter is needed if the mask is different of 0xf.

Ludovic Barre (2):
  dt-bindings: pinctrl: add syscfg mask parameter
  pinctrl: stm32: add syscfg mask parameter

 .../devicetree/bindings/pinctrl/st,stm32-pinctrl.txt     |  7 ++++---
 drivers/pinctrl/stm32/pinctrl-stm32.c                    | 16 ++++++++++++++--
 2 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.7.4

From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Thu, 12 May 2016 16:46:33 +0200
Subject: [PATCH 0/2] pinctrl: stm32: .pin_config_dbg_show fixes
Message-ID: <1463064395-4669-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Patrice Chotard (2):
  pinctrl: stm32: fix warning
  pinctrl: stm32: factorize stm32_pconf_input/output_get()

 drivers/pinctrl/stm32/pinctrl-stm32.c | 39 +++++++++++++----------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

-- 
1.9.1

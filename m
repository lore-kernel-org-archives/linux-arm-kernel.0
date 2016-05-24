From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 24 May 2016 13:57:42 +0200
Subject: [PATCH v2] pinctrl: stm32: .pin_config_dbg_show fixes
Message-ID: <1464091063-22341-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

v1 -> v2
	_ rebase on top of Linus Torsvald tree.
	_ remove "[PATCH 1/2]: pinctrl: stm32: fix warning", already fixed by Linus Torvalds

Patrice Chotard (1):
  pinctrl: stm32: factorize stm32_pconf_input/output_get()

 drivers/pinctrl/stm32/pinctrl-stm32.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

-- 
1.9.1

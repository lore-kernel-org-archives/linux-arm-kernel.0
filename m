From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Fri, 20 Apr 2018 17:54:39 +0200
Subject: [PATCH 0/5] ARM: dts: STi: Fix complain about IRQ_TYPE_NONE_usage 
Message-ID: <1524239684-25463-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Fix the STi following DT files which make usage of IRQ_TYPE_NONE flag:
 _ stih407-family.dtsi
 _ stih407-pinctrl.dtsi
 _ stih407.dtsi
 _ stih410.dtsi
 _ stihxxx-b2120.dtsi  

Patrice Chotard (5):
  ARM: dts: stih407-family: Fix complain about IRQ_TYPE_NONE usage
  ARM: dts: stih407-pinctrl: Fix complain about IRQ_TYPE_NONE usage
  ARM: dts: stih407: Fix complain about IRQ_TYPE_NONE usage
  ARM: dts: stih410: Fix complain about IRQ_TYPE_NONE usage
  ARM: dts: stihxxx-b2120: Fix complain about IRQ_TYPE_NONE usage

 arch/arm/boot/dts/stih407-family.dtsi  | 52 +++++++++++++++++-----------------
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 10 +++----
 arch/arm/boot/dts/stih407.dtsi         |  2 +-
 arch/arm/boot/dts/stih410.dtsi         | 18 ++++++------
 arch/arm/boot/dts/stihxxx-b2120.dtsi   |  4 +--
 5 files changed, 43 insertions(+), 43 deletions(-)

-- 
1.9.1

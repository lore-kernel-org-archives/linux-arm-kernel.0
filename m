From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Tue,  9 Jul 2013 08:25:52 +0100
Subject: [PATCH v2 0/2] ARM: STi Fixes
Message-ID: <1373354752-26292-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch series fixes 2 configuration issues related to serial
setup on STiH416 and ARM ERRATA selection.

Changes since v1:
	- Split out fixes in seperate patch set.

Srinivas Kandagatla (2):
  ARM: dts: STi: Fix pinconf setup for STiH416 serial2
  ARM: STi: Set correct ARM ERRATAs.

 arch/arm/boot/dts/stih416-pinctrl.dtsi |   10 +++++++++-
 arch/arm/boot/dts/stih416.dtsi         |    2 +-
 arch/arm/mach-sti/Kconfig              |    3 ++-
 3 files changed, 12 insertions(+), 3 deletions(-)

-- 
1.7.6.5

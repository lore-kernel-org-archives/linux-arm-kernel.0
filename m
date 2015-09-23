From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 23 Sep 2015 21:37:26 +0200
Subject: [PATCH 0/3] ARM: dts: Various STi DT clean-ups
Message-ID: <1443037049-6167-1-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series cleans the STi407 family DTs, by factorizing common nodes between
STiH407 and STiH410, and also by only enabling PWM and USB nodes at board
level, as they could not be exposed on some boards.

Maxime Coquelin (3):
  ARM: dts: stih407: Enable PWM nodes only board level
  ARM: dts: stih407/410: Tidy up display nodes
  ARM: dts: stih410: Enable USB2.0 and related PHY nodes at board level

 arch/arm/boot/dts/stih407-family.dtsi | 19 +++++++++++++++++--
 arch/arm/boot/dts/stih407.dtsi        | 13 -------------
 arch/arm/boot/dts/stih410-b2120.dts   | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/stih410.dtsi        | 23 +++++++++++------------
 arch/arm/boot/dts/stihxxx-b2120.dtsi  |  8 ++++++++
 5 files changed, 60 insertions(+), 27 deletions(-)

-- 
1.9.1

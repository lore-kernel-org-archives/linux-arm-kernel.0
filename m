From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Wed, 9 May 2018 17:18:12 +0200
Subject: [PATCH 0/2] ARM: dts: stm32: update rtc st,syscfg
Message-ID: <1525879094-19562-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the lastest STM32 RTC driver updates, it is mandatory to define
pwrcfg control register and DBP (Disable Backup Protection) bit through
st,syscfg property. This patchset updates RTC nodes on stm32f429 and
stm32f746 accordingly.

Amelie Delaunay (2):
  ARM: dts: stm32: update rtc st,syscfg property on stm32f429
  ARM: dts: stm32: update rtc st,syscfg property on stm32f746

 arch/arm/boot/dts/stm32f429.dtsi | 2 +-
 arch/arm/boot/dts/stm32f746.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4

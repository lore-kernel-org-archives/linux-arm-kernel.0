From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Fri, 16 Feb 2018 14:16:38 +0100
Subject: [PATCH 0/2] RTC support on STM32H743
Message-ID: <1518787000-10675-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add support for RTC on STM32H743 and enables it on stm32h743i-eval.
Tested on stm32-next.

Amelie Delaunay (2):
  ARM: dts: stm32: add RTC support on STM32H743
  ARM: dts: stm32: enable RTC on stm32h743i-eval

 arch/arm/boot/dts/stm32h743.dtsi      | 15 +++++++++++++++
 arch/arm/boot/dts/stm32h743i-eval.dts |  4 ++++
 2 files changed, 19 insertions(+)

-- 
2.7.4

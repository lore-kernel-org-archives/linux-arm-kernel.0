From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Mon, 19 Feb 2018 09:46:25 +0100
Subject: [PATCH v2 0/3] USB OTG on STM32H743
Message-ID: <1519029988-9261-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for USB OTG HS and FS on stm32h743 SoC.
It also enables USB OTG HS on stm32h743i-eval board in OTG (DRD) mode. It is
possible to use OTG HS in Peripheral or Host mode depending on the USB
connector.

---

Changes in v2:
- Fix compatible string (https://patchwork.kernel.org/patch/10222153/)

Amelie Delaunay (3):
  ARM: dts: stm32: add USB OTG HS support for STM32H743 SoC
  ARM: dts: stm32: add USB OTG FS support for STM32H743 SoC
  ARM: dts: stm32: enable USB OTG HS on stm32h743i-eval

 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/stm32h743.dtsi         | 21 +++++++++++++++++++++
 arch/arm/boot/dts/stm32h743i-eval.dts    | 16 ++++++++++++++++
 3 files changed, 57 insertions(+)

-- 
2.7.4

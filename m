From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon, 25 Aug 2014 16:44:44 +0200
Subject: [RESEND PATCH 0/4] Enables STMicroelectronics Flexgen Clock support
Message-ID: <1408977888-10473-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches enables clock drivers for STih407 boards.

Gabriel Fernandez (4):
  ARM: STi: DT: STiH407: 407 DT Entry for clockgen A0
  ARM: STi: DT: STiH407: 407 DT Entry for clockgen C0
  ARM: STi: DT: STiH407: 407 DT Entry for clockgen D0/D2/D3
  ARM: STi: DT: STiH407: 407 DT Entry for clockgenA9

 arch/arm/boot/dts/stih407-clock.dtsi     | 295 ++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/stih407.dtsi           |  18 +-
 include/dt-bindings/clock/stih407-clks.h |  11 ++
 3 files changed, 307 insertions(+), 17 deletions(-)
 create mode 100644 include/dt-bindings/clock/stih407-clks.h

-- 
1.9.1

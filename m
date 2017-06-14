From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 14 Jun 2017 17:13:13 +0200
Subject: [PATCH v2 0/3] Fix STM32 timers dt-bindings
Message-ID: <1497453196-31470-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 timers clock names has been updated during driver/DT binding review:
https://lkml.org/lkml/2016/12/13/718

STM32 timers driver has been fixed with these remarks. It looks like it's
been missed on DT binding part.
Update DT binding doc to reflect this as well.
---
Changes in v2:
- Also fix stm32 pwm dt-bindings
- Add Fixes tags

Fabrice Gasnier (3):
  dt-bindings: mfd: update STM32 timers clock names
  dt-bindings: iio: update STM32 timers clock names
  dt-bindings: pwm: update STM32 timers clock names

 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 2 +-
 Documentation/devicetree/bindings/mfd/stm32-timers.txt              | 2 +-
 Documentation/devicetree/bindings/pwm/pwm-stm32.txt                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1

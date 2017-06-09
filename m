From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Fri, 9 Jun 2017 09:37:52 +0200
Subject: [PATCH 0/2] Fix STM32 timers dt-bindings
Message-ID: <1496993874-9870-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 timers clock names has been updated during driver/DT binding review:
https://lkml.org/lkml/2016/12/13/718

STM32 timers driver has been fixed with these remarks. It looks like it's
been missed on DT binding part.
Update DT binding doc to reflect this as well.

Fabrice Gasnier (2):
  dt-bindings: mfd: update STM32 timers clock names
  dt-bindings: iio: update STM32 timers clock names

 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 2 +-
 Documentation/devicetree/bindings/mfd/stm32-timers.txt              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1

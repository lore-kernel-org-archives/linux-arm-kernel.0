From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Thu, 27 Jul 2017 18:18:56 +0200
Subject: [PATCH 0/4] iio: trigger: stm32-timer fixes
Message-ID: <1501172340-8448-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Miscellaneous fixes for stm32-timer-trigger driver.
Last patch adds enable attribute, which unlocks use of
encoder mode.

Fabrice Gasnier (4):
  iio: trigger: stm32-timer: fix quadrature mode get routine
  iio: trigger: stm32-timer: fix write_raw return value
  iio: trigger: stm32-timer: fix get/set down count direction
  iio: trigger: stm32-timer: add enable attribute

 drivers/iio/trigger/stm32-timer-trigger.c | 80 ++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 22 deletions(-)

-- 
1.9.1

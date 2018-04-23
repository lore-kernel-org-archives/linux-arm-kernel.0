From: lionel.debieve@st.com (Lionel Debieve)
Date: Mon, 23 Apr 2018 17:04:24 +0200
Subject: [PATCH 0/2] Fix stm32-rng for default state and suspend
Message-ID: <20180423150426.22198-1-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series are fixing the default build state for stm32-rng that
activate the driver with arm multi_v7_defconfig.
Second patch is fixing the power suspend/resume behavior which was
not working.

Lionel Debieve (2):
  hwrng: stm32 - define default state for rng driver
  hwrng: stm32-rng: Fix pm_suspend issue

 drivers/char/hw_random/Kconfig     | 1 +
 drivers/char/hw_random/stm32-rng.c | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.15.1

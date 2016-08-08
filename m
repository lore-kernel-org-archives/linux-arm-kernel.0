From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 8 Aug 2016 13:01:32 +0100
Subject: [PATCH v5 0/7] mfd: ac100: Add support for X-Powers AC100 audio
 codec / RTC combo IC
In-Reply-To: <1467988422-17934-1-git-send-email-wens@csie.org>
References: <1467988422-17934-1-git-send-email-wens@csie.org>
Message-ID: <20160808120132.GQ5243@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enjoy!

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-rtc-v4.9

for you to fetch changes up to 04940631b8d2b2e57a13b6d4ca50dfe5994b514f:

  rtc: ac100: Add clk output support (2016-08-08 12:54:05 +0100)

----------------------------------------------------------------
Immutable branch between MFD and RTC, due for the v4.9 merge-window.

----------------------------------------------------------------
Chen-Yu Tsai (4):
      mfd: ac100: Add device tree bindings for X-Powers AC100 codec/RTC combo IC
      mfd: ac100: Add driver for X-Powers AC100 audio codec / RTC combo IC
      rtc: ac100: Add RTC driver for X-Powers AC100
      rtc: ac100: Add clk output support

 Documentation/devicetree/bindings/mfd/ac100.txt |  54 ++
 drivers/mfd/Kconfig                             |  10 +
 drivers/mfd/Makefile                            |   2 +
 drivers/mfd/ac100.c                             | 137 ++++++
 drivers/rtc/Kconfig                             |  10 +
 drivers/rtc/Makefile                            |   1 +
 drivers/rtc/rtc-ac100.c                         | 627 ++++++++++++++++++++++++
 include/linux/mfd/ac100.h                       | 178 +++++++
 8 files changed, 1019 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt
 create mode 100644 drivers/mfd/ac100.c
 create mode 100644 drivers/rtc/rtc-ac100.c
 create mode 100644 include/linux/mfd/ac100.h

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

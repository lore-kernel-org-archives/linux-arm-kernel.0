From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 11 Aug 2015 11:12:45 +0200
Subject: [PATCH v3 0/5] power/reset: at91: cleanups and slow clock
Message-ID: <1439284370-13803-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As discussed this series is now removing non DT initialization, allowing to
compile the drivers as modules and finally adding slow clock support to the
drivers.


Alexandre Belloni (5):
  power/reset: at91-reset: remove useless at91_reset_platform_probe()
  power/reset: at91-reset: allow compiling as a module
  power/reset: at91-reset: get and use slow clock
  power/reset: at91-poweroff: allow compiling as a module
  power/reset: at91-poweroff: get and use slow clock

 drivers/power/reset/Kconfig         |  4 +--
 drivers/power/reset/at91-poweroff.c | 33 ++++++++++++++++--
 drivers/power/reset/at91-reset.c    | 67 ++++++++++++++-----------------------
 3 files changed, 58 insertions(+), 46 deletions(-)

-- 
2.1.4

From: carlo@caione.org (Carlo Caione)
Date: Mon, 15 Sep 2014 15:11:29 +0200
Subject: [PATCH 0/2] ARM: meson: add clocksource support
Message-ID: <1410786691-30302-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two patches taken from patchset http://www.spinics.net/lists/devicetree/msg48979.html
adding support for clocksource and clockevents driver.

Daniel and Thomas,
if it's fine with you, could you please take these patches in the clocksource
tree?

Thanks,

Carlo Caione (2):
  ARM: meson: documentation: add timer documentation
  ARM: meson6: clocksource: add Meson6 timer support

 .../bindings/timer/amlogic,meson6-timer.txt        |  16 ++
 drivers/clocksource/Kconfig                        |   3 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/meson6_timer.c                 | 167 +++++++++++++++++++++
 4 files changed, 187 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
 create mode 100644 drivers/clocksource/meson6_timer.c

-- 
1.9.1

From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:44:30 +0000
Subject: [PATCH 00/40] Power: AB8500: Internal development push
Message-ID: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anton,

This is the 3rd and final instalment of the push to synchronise
the ABx500 Battery Management series of internal development patches
due for Mainline.

This patch-set submission is for reviewing purposes only. Please
don't apply patches directly from this patch-set, as there are some
interdependencies with another patch-set due for the MFD tree. We
can chat about how to over-come this at a later date.

Enjoy! =:-)

 drivers/mfd/ab8500-core.c                 |   36 +++++++
 drivers/power/Kconfig                     |    7 --
 drivers/power/Makefile                    |    3 +-
 drivers/power/ab8500_bmdata.c             |   96 ++++++++++++++++-
 drivers/power/ab8500_btemp.c              |   75 +++++++++++---
 drivers/power/ab8500_charger.c            |  699 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------
 drivers/power/ab8500_fg.c                 |  449 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 drivers/power/abx500_chargalg.c           |  455 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
 drivers/power/pm2301_charger.c            |  365 +++++++++++++++++++++++++++++++++++++++++++++++-----------------
 drivers/power/pm2301_charger.h            |   23 +----
 include/linux/mfd/abx500.h                |   21 +++-
 include/linux/mfd/abx500/ab8500-bm.h      |   60 ++++++++++-
 include/linux/mfd/abx500/ab8500.h         |   46 +++++++++
 include/linux/mfd/abx500/ux500_chargalg.h |    7 ++
 include/linux/pm2301_charger.h            |    2 +-
 15 files changed, 1842 insertions(+), 502 deletions(-)

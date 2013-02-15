From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:56:31 +0000
Subject: [PATCH 00/35] mfd: ab8500: Internal development push
Message-ID: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sam,

This is the patch-set we've been speaking about. It's the entire
development history for the ABx500 related MFD changes from
ST-Ericsson's internal kernel. This brings us bang up-to-date.

Please don't apply patches directly from this submission, as
there are some interdependencies which we need to sort out
between you, Anton and I.

Enjoy! =:-)


 drivers/mfd/ab8500-core.c                 |  524 +++++++++++++++++++-------
 drivers/mfd/ab8500-debugfs.c              | 2511 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
 drivers/mfd/ab8500-gpadc.c                |  577 +++++++++++++++++++++++------
 drivers/mfd/ab8500-sysctrl.c              |   98 ++++-
 include/linux/mfd/abx500.h                |    2 -
 include/linux/mfd/abx500/ab8500-gpadc.h   |   74 +++-
 include/linux/mfd/abx500/ab8500-sysctrl.h |    6 +
 include/linux/mfd/abx500/ab8500.h         |  242 +++++++++---
 8 files changed, 3177 insertions(+), 857 deletions(-)

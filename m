From: nicolae.rosia.oss@gmail.com (Nicolae Rosia)
Date: Tue,  4 Oct 2016 15:46:15 +0300
Subject: [PATCH 0/2] tty: serial: kgdb support for fsl_lpuart
Message-ID: <1475585177-28777-1-git-send-email-nicolae.rosia.oss@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolae Rosia <nicolae_rosia@mentor.com>

This patch series enables kgdb to be used with fsl_lpuart
on Vybrid processors.

Tested on Vybrid VF61

Nicolae Rosia (2):
  tty: serial: fsl_lpuart: add polled console functions
  tty: serial: Makefile: move kgdb to be initialized last

 drivers/tty/serial/Makefile     |  5 ++--
 drivers/tty/serial/fsl_lpuart.c | 66 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)

-- 
2.5.5

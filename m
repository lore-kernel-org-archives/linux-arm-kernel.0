From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 2 Aug 2013 16:37:39 +0800
Subject: [PATCH 0/3] Misc Chipidea Patch
Message-ID: <1375432662-32018-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on my vbus/id patchset

Peter Chen (3):
  usb: chipidea: udc: fix the oops when plugs in usb cable after rmmod
    gadget
  usb: chipidea: move platform related things to ci_get_platdata
  usb: host: delete chipidea dependency

 drivers/usb/chipidea/core.c |   21 +++++++++------------
 drivers/usb/chipidea/udc.c  |   13 +++++++++----
 drivers/usb/host/Kconfig    |    4 ++--
 3 files changed, 20 insertions(+), 18 deletions(-)

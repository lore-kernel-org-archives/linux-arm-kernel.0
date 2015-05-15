From: tremyfr@gmail.com (Philippe Reynes)
Date: Sat, 16 May 2015 00:35:28 +0200
Subject: [PATCH 0/2] add dt support for mxc rtc
Message-ID: <1431729330-7625-1-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set add the device tree support for
the rtc driver on mxc.

Philippe Reynes (2):
  rtc: mxc: add a second clock
  rtc: mxc: add support of device tree

 Documentation/devicetree/bindings/rtc/rtc-mxc.txt |   27 ++++++++++++
 arch/arm/mach-imx/clk-imx31.c                     |    3 +-
 drivers/rtc/rtc-mxc.c                             |   48 ++++++++++++++++----
 3 files changed, 67 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc.txt

-- 
1.7.4.4

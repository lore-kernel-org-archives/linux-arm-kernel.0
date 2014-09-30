From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 30 Sep 2014 10:00:33 +0800
Subject: [PATCH 0/6] ARM: imx_v6_v7_defconfig: enable several usb functions
Message-ID: <1412042439-13977-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

This series enables several usb functions for both host and device
mode which are used commonly, and all is built as modules.

Peter Chen (6):
  ARM: imx_v6_v7_defconfig: enable USB Ethernet support at host mode
  ARM: imx_v6_v7_defconfig: enable usb media feature for host mode
  ARM: imx_v6_v7_defconfig: enable USB audio at host mode
  ARM: imx_v6_v7_defconfig: enable USB serial at host mode
  ARM: imx_v6_v7_defconfig: enable USB EHSET driver
  ARM: imx_v6_v7_defconfig: enable several usb gadgets

 arch/arm/configs/imx_v6_v7_defconfig |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

-- 
1.7.9.5

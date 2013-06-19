From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 19 Jun 2013 10:53:02 -0700
Subject: [PATCH RFC 0/2] Extend multi_v7_defconfig
Message-ID: <1371664384-24974-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I don't know how much a defconfig is supposed to provide, hence as RFC.
This patches are needed for booting Zynq into a minimum ramfs based
system with a serial console.

	Thanks,
	S?ren

Soren Brinkmann (2):
  arm: multi_v7_defconfig: Enable Zynq UART driver
  arm: multi_v7_defconfig: Enable initrd/initramfs support

 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

-- 
1.8.3.1

From: lkp@intel.com (kbuild test robot)
Date: Mon, 28 Sep 2015 11:48:08 +0800
Subject: [PATCH v2 1/8] spi: imx: Fix DMA transfer
In-Reply-To: <d61ed8cc9e13b0890e6243135c613edea1234698.1442923630.git.anton_bondarenko@mentor.com>
Message-ID: <201509281125.KBKxMzor%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anton,

[auto build test results on v4.3-rc2 -- if it's inappropriate base, please ignore]

config: arm-arm5 (attached as .config)
reproduce:
  wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
  chmod +x ~/bin/make.cross
  git checkout 82f1264caef01600e640af28b9f92d5a86efd25b
  # save the attached .config to linux build tree
  make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

>> ERROR: "arm926_dma_flush_range" [drivers/spi/spi-imx.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25917 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150928/071e0613/attachment-0001.obj>

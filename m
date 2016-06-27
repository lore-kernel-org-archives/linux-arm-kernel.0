From: lkp@intel.com (kbuild test robot)
Date: Mon, 27 Jun 2016 11:41:39 +0800
Subject: [PATCH 18/21] usb: chipidea: msm: Add reset controller for PHY
 POR bit
In-Reply-To: <20160626072838.28082-19-stephen.boyd@linaro.org>
Message-ID: <201606271118.CClHWAdr%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on peter.chen-usb/ci-for-usb-next]
[also build test ERROR on v4.7-rc5 next-20160624]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/Support-qcom-s-HSIC-USB-and-rewrite-USB2-HS-phy-support/20160627-102637
base:   https://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb ci-for-usb-next
config: x86_64-acpi-redef (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `ci_hdrc_msm_remove':
>> ci_hdrc_msm.c:(.text+0x4fffd2): undefined reference to `reset_controller_unregister'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 28294 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160627/ad1e2216/attachment-0001.obj>

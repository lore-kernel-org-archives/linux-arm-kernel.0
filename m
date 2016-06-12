From: lkp@intel.com (kbuild test robot)
Date: Sun, 12 Jun 2016 12:14:13 +0800
Subject: [PATCH v3,4/5] usb: Add MediaTek USB3 DRD Driver
In-Reply-To: <1465543962-11678-5-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <201606121211.aP7WlrOd%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on v4.7-rc2 next-20160609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chunfeng-Yun/usb-Add-MediaTek-USB3-DRD-Driver/20160610-153559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: i386-randconfig-x011-06120748 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

warning: (USB_MTU3) selects USB_XHCI_MTK which has unmet direct dependencies (USB_SUPPORT && USB && USB_XHCI_HCD && (ARCH_MEDIATEK || COMPILE_TEST))
   drivers/built-in.o: In function `mtu3_probe':
>> mtu3_plat.c:(.text+0x21471d): undefined reference to `extcon_get_edev_by_phandle'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 27652 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160612/d55e8007/attachment-0001.obj>

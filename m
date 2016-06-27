From: lkp@intel.com (kbuild test robot)
Date: Mon, 27 Jun 2016 12:21:42 +0800
Subject: [PATCH 02/21] usb: ulpi: Support device discovery via DT
In-Reply-To: <20160626072838.28082-3-stephen.boyd@linaro.org>
Message-ID: <201606271231.FAER38dN%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on peter.chen-usb/ci-for-usb-next]
[also build test ERROR on v4.7-rc5 next-20160624]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/Support-qcom-s-HSIC-USB-and-rewrite-USB2-HS-phy-support/20160627-102637
base:   https://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb ci-for-usb-next
config: x86_64-randconfig-h0-06270614 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> ERROR: "of_device_request_module" [drivers/usb/common/ulpi.ko] undefined!
>> ERROR: "of_device_get_modalias" [drivers/usb/common/ulpi.ko] undefined!
>> ERROR: "of_device_uevent_modalias" [drivers/usb/common/ulpi.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 22307 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160627/cb33d152/attachment-0001.obj>

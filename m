From: lkp@intel.com (kbuild test robot)
Date: Sun, 8 Nov 2015 17:32:38 +0800
Subject: [PATCH V3 2/4] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <1446958380-23298-3-git-send-email-okaya@codeaurora.org>
Message-ID: <201511081742.Opjz2Q2o%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

[auto build test ERROR on: robh/for-next]
[also build test ERROR on: v4.3 next-20151106]

url:    https://github.com/0day-ci/linux/commits/Sinan-Kaya/ma-add-Qualcomm-Technologies-HIDMA-driver/20151108-125824
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "hidma_mgmt_setup" undefined!
>> ERROR: "hidma_mgmt_init_sys" undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51612 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151108/914a6771/attachment-0001.obj>

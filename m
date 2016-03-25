From: lkp@intel.com (kbuild test robot)
Date: Fri, 25 Mar 2016 12:39:12 +0800
Subject: [PATCH 1/1] usb: chipidea: add DMA mask configuration API
In-Reply-To: <20160325040234.GA6185@peterchendt>
Message-ID: <201603251224.amlQiwhC%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

[auto build test ERROR on v4.5-rc7]
[also build test ERROR on next-20160324]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Chen/usb-chipidea-add-DMA-mask-configuration-API/20160325-120535
config: i386-randconfig-s1-201612 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "ci_hdrc_set_dma_mask" [drivers/usb/chipidea/ci_hdrc_msm.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 23634 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160325/301371ff/attachment-0001.obj>

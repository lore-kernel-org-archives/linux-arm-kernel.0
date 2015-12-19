From: lkp@intel.com (kbuild test robot)
Date: Sat, 19 Dec 2015 15:37:05 +0800
Subject: [PATCH V10 7/7] dma: qcom_hidma: add support for object hierarchy
In-Reply-To: <1450371684-23415-8-git-send-email-okaya@codeaurora.org>
Message-ID: <201512191503.k4p1BXza%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

[auto build test ERROR on v4.4-rc5]
[also build test ERROR on next-20151218]

url:    https://github.com/0day-ci/linux/commits/Sinan-Kaya/dma-add-Qualcomm-Technologies-HIDMA-driver/20151218-010637
config: sparc64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

>> ERROR: "of_irq_parse_one" [drivers/dma/qcom/hdma_mgmt.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44094 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151219/34964eef/attachment-0001.obj>

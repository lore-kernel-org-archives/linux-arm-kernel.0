From: lkp@intel.com (kbuild test robot)
Date: Sat, 19 Dec 2015 15:14:17 +0800
Subject: [PATCH V10 7/7] dma: qcom_hidma: add support for object hierarchy
In-Reply-To: <1450371684-23415-8-git-send-email-okaya@codeaurora.org>
Message-ID: <201512191520.8X85HnZ5%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

[auto build test ERROR on v4.4-rc5]
[also build test ERROR on next-20151218]

url:    https://github.com/0day-ci/linux/commits/Sinan-Kaya/dma-add-Qualcomm-Technologies-HIDMA-driver/20151218-010637
config: sparc-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `hidma_mgmt_of_populate_channels':
>> hidma_mgmt.c:(.init.text+0x5cc8): undefined reference to `of_irq_parse_one'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44406 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151219/cd75a00a/attachment-0001.obj>

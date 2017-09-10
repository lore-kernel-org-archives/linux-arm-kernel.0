From: lkp@intel.com (kbuild test robot)
Date: Sun, 10 Sep 2017 20:13:23 +0800
Subject: [PATCH v4 6/6] gpio: uniphier: add UniPhier GPIO controller driver
In-Reply-To: <1504784522-26841-7-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <201709102009.mXD4Fpgu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

[auto build test ERROR on tip/irq/core]
[also build test ERROR on next-20170908]
[cannot apply to v4.13]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/irqdomain-gpio-expand-irq_domain_push_irq-for-DT-use-and-use-it-for-GPIO/20170910-160507
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "of_irq_count" [drivers/gpio/gpio-uniphier.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60564 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170910/af601c03/attachment-0001.gz>

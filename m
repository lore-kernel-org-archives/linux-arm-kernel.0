From: lkp@intel.com (kbuild test robot)
Date: Mon, 19 Oct 2015 22:04:33 +0800
Subject: [PATCH v10 3/6] pci:host: Add Altera PCIe host controller driver
In-Reply-To: <1445242768-4423-4-git-send-email-lftan@altera.com>
Message-ID: <201510192217.AS3g74oU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ley,

[auto build test ERROR on pci/next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Ley-Foon-Tan/arm-add-msi-h-to-Kbuild/20151019-162417
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "pci_fixup_irqs" undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51506 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151019/93b16dd8/attachment-0001.obj>

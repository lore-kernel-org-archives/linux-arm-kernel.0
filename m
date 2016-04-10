From: lkp@intel.com (kbuild test robot)
Date: Sun, 10 Apr 2016 10:59:46 +0800
Subject: [PATCH 1/2] PCI: iproc: Support DT property for ignoring aborts
 when probing
In-Reply-To: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
Message-ID: <201604101000.oQktaJEg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafa?,

[auto build test ERROR on pci/next]
[also build test ERROR on v4.6-rc2 next-20160408]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Rafa-Mi-ecki/PCI-iproc-Support-DT-property-for-ignoring-aborts-when-probing/20160410-055241
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: "hook_fault_code" [drivers/pci/host/pcie-iproc.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 56979 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160410/a13388e0/attachment-0001.obj>

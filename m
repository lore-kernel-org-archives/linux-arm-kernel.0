From: lkp@intel.com (kbuild test robot)
Date: Thu, 17 Dec 2015 20:46:03 +0800
Subject: [PATCH V2 10/10] acpi, gicv3, its: Use MADT ITS subtable to do
 PCI/MSI domain initialization.
In-Reply-To: <1450353133-15992-11-git-send-email-tn@semihalf.com>
Message-ID: <201512172029.JF6K6l2j%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

[auto build test ERROR on v4.4-rc4]
[also build test ERROR on next-20151217]
[cannot apply to tip/irq/core v4.4-rc5]

url:    https://github.com/0day-ci/linux/commits/Tomasz-Nowicki/Introduce-ACPI-world-to-GICv3-ITS-irqchip/20151217-195910
config: i386-randconfig-s1-12171706 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `pci_msi_domain_get_msi_rid':
>> (.text+0x3175d): undefined reference to `iort_find_pci_id'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 24633 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151217/1659c2ca/attachment-0001.obj>

From: lkp@intel.com (kbuild test robot)
Date: Fri, 26 May 2017 08:03:01 +0800
Subject: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
In-Reply-To: <1495712248-5232-6-git-send-email-gabriele.paoloni@huawei.com>
Message-ID: <201705260735.XlDFJKOH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriele,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.12-rc2 next-20170525]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Gabriele-Paoloni/LPC-legacy-ISA-I-O-support/20170526-033719
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `acpi_scan_init':
>> (.init.text+0x6742): undefined reference to `acpi_indirectio_scan_init'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47743 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170526/e1dfddfc/attachment-0001.gz>

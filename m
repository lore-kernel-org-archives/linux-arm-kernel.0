From: lkp@intel.com (kbuild test robot)
Date: Tue, 6 Dec 2016 16:37:48 +0800
Subject: [PATCH 2/2] arm64: dts: NS2: add support for XMC form factor
In-Reply-To: <1480979542-26871-3-git-send-email-jon.mason@broadcom.com>
Message-ID: <201612061647.t3qcDWHR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.9-rc8]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jon-Mason/arm64-dts-NS2-reserve-memory-for-Nitro-firmware/20161206-125631
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/broadcom/ns2-xmc.dts:56.1-6 Label or path enet not found
>> Error: arch/arm64/boot/dts/broadcom/ns2-xmc.dts:132.1-7 Label or path pcie8 not found
>> Error: arch/arm64/boot/dts/broadcom/ns2-xmc.dts:148.1-6 Label or path qspi not found
>> FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52465 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161206/fc197763/attachment-0001.gz>

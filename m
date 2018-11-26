From: lkp@intel.com (kbuild test robot)
Date: Tue, 27 Nov 2018 00:59:17 +0800
Subject: [PATCH v3 4/4] arm64: dts: actions: s700-cubieboard7: Enable SIRQ
In-Reply-To: <20181126100940.2944780-1-pn@denx.de>
References: <20181126100940.2944780-1-pn@denx.de>
Message-ID: <201811270010.jiasM1Ez%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Parthiban,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on v4.20-rc4 next-20181126]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Parthiban-Nallathambi/Add-Actions-Semi-Owl-family-sirq-support/20181126-181439
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/actions/s700-cubieboard7.dts:46.1-9 Label or path pinctrl not found
>> FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61742 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/576b5316/attachment-0001.gz>

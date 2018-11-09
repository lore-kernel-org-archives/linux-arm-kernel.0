From: lkp@intel.com (kbuild test robot)
Date: Fri, 9 Nov 2018 09:31:15 +0800
Subject: [PATCH 3/3] ARM64: dts: meson-gxl: Add support for the Smartlabs
 SML-5442TW
In-Reply-To: <1541691207-24768-3-git-send-email-christianshewitt@gmail.com>
References: <1541691207-24768-3-git-send-email-christianshewitt@gmail.com>
Message-ID: <201811090923.kiVN8vPL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.20-rc1 next-20181108]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christian-Hewitt/dt-bindings-Add-vendor-prefix-for-Smartlabs/20181109-010512
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-allyesconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts:172.1-7 Label or path audio not found
>> Error: arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts:176.1-13 Label or path aiu_i2s_dma not found
>> Error: arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts:180.1-9 Label or path i2s_dai not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61776 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181109/ef520d27/attachment-0001.gz>

From: lkp@intel.com (kbuild test robot)
Date: Mon, 29 May 2017 00:02:00 +0800
Subject: [PATCH v4 7/9] arm: dts: mt7623: enable the usb device on the
 mt7623n rfb
In-Reply-To: <4cb528c77f4d44bd0932b69f39b0d5b557d9eab1.1495683769.git.sean.wang@mediatek.com>
Message-ID: <201705282334.smDMEWQD%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.12-rc2 next-20170526]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/sean-wang-mediatek-com/arm-dts-extend-mt7623-support/20170525-142103
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-allyesconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   Error: arch/arm/boot/dts/mt7623-mt6323.dtsi:33.1-7 Label or path pwrap not found
   Error: arch/arm/boot/dts/mt7623-mt6323.dtsi:261.1-6 Label or path mmc0 not found
   Error: arch/arm/boot/dts/mt7623-mt6323.dtsi:266.1-6 Label or path mmc1 not found
>> Error: arch/arm/boot/dts/mt7623n-rfb.dtsi:37.20-21 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60535 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170529/3a4fb54a/attachment-0001.gz>

From: lkp@intel.com (kbuild test robot)
Date: Sat, 22 Apr 2017 10:52:08 +0800
Subject: [PATCH 5/5 v3] ARM: dts: Add the FOTG210 USB host to Gemini
In-Reply-To: <20170421204058.6206-5-linus.walleij@linaro.org>
Message-ID: <201704221033.gRgELoti%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

[auto build test ERROR on next-20170421]
[cannot apply to robh/for-next usb/usb-testing balbi-usb/next v4.9-rc8 v4.9-rc7 v4.9-rc6 v4.11-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Linus-Walleij/usb-host-add-DT-bindings-for-faraday-fotg2/20170422-072414
config: arm-sama5_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/gemini.dtsi:161.19-20 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24300 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170422/a2a86dda/attachment-0001.gz>

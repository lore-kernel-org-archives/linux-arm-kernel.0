From: lkp@intel.com (kbuild test robot)
Date: Sun, 14 Aug 2016 13:25:40 +0800
Subject: [PATCH v2 1/2] ARM64: dts: meson-gxbb: add MMC support
In-Reply-To: <20160803231843.23012-1-khilman@baylibre.com>
Message-ID: <201608141319.AeQlvjsy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.8-rc1 next-20160812]
[cannot apply to ulf.hansson-mmc/next robh/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kevin-Hilman/ARM64-dts-meson-gxbb-add-MMC-support/20160804-072056
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi:338.21-22 syntax error
>> FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 29377 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160814/37296eba/attachment-0001.obj>

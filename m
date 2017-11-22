From: lkp@intel.com (kbuild test robot)
Date: Wed, 22 Nov 2017 22:04:53 +0800
Subject: [PATCH 2/2] ARM: dts: TS-7970: add basic device tree
In-Reply-To: <20171120211557.27946-2-sebastien.bourdelin@savoirfairelinux.com>
References: <20171120211557.27946-2-sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <201711222147.qEdeLICp%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastien,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on v4.14 next-20171121]
[cannot apply to robh/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sebastien-Bourdelin/of-documentation-add-bindings-documentation-for-TS-7970/20171122-195011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/imx6dl-ts7970.dts:52.1-6 Label or path sata not found
>> FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23369 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171122/42038746/attachment-0001.gz>

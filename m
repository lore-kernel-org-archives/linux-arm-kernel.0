From: lkp@intel.com (kbuild test robot)
Date: Mon, 4 Dec 2017 07:13:05 +0800
Subject: [PATCH 1/4] arm: dts: imx28: Use phandles instead of unit
 addresses
In-Reply-To: <1512110311-15788-2-git-send-email-venkataravi.e@techveda.org>
References: <1512110311-15788-2-git-send-email-venkataravi.e@techveda.org>
Message-ID: <201712040750.oAKvTih2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ravi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on v4.15-rc2 next-20171201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/venkataravi-e-techveda-org/arm-dts-imx28-Use-phandles-instead-of-unit-addresses/20171204-023409
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/venkataravi-e-techveda-org/arm-dts-imx28-Use-phandles-instead-of-unit-addresses/20171204-023409 HEAD c17ed56cb053430c58e4b6748774a1f195df2627 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/imx28-evk.dts:25.4-9 syntax error
>> FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23569 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171204/60da5c70/attachment-0001.gz>

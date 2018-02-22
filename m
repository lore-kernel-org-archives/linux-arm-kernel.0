From: lkp@intel.com (kbuild test robot)
Date: Thu, 22 Feb 2018 10:57:28 +0800
Subject: [PATCH v4 4/6] arm64: dts: exynos: add OF graph between MHL and
 USB connector
In-Reply-To: <20180221085541.14556-5-a.hajda@samsung.com>
References: <20180221085541.14556-5-a.hajda@samsung.com>
Message-ID: <201802221029.DemtGxRD%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrzej,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.16-rc2 next-20180221]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrzej-Hajda/dt-bindings-add-bindings-for-USB-physical-connector/20180221-185759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi:864.1-2 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38172 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180222/f896efce/attachment-0001.gz>

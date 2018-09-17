From: lkp@intel.com (kbuild test robot)
Date: Mon, 17 Sep 2018 22:46:49 +0800
Subject: [PATCH] arm64: dts: rockchip: add spdif sound node for rock64
In-Reply-To: <20180917090236.21948-1-katsuhiro@katsuster.net>
References: <20180917090236.21948-1-katsuhiro@katsuster.net>
Message-ID: <201809172243.C2EHNtuW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Katsuhiro,

I love your patch! Yet something to improve:

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.19-rc4 next-20180913]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Katsuhiro-Suzuki/arm64-dts-rockchip-add-spdif-sound-node-for-rock64/20180917-172217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/rockchip/rk3328-rock64.dts:286.1-12 Label or path spdif_p0_0 not found
>> FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60972 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180917/087c6ff3/attachment-0001.gz>

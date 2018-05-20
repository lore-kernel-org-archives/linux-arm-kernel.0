From: lkp@intel.com (kbuild test robot)
Date: Mon, 21 May 2018 07:28:36 +0800
Subject: [PATCH v3 2/3] arm64: dts: renesas: draak: Describe CVBS input
In-Reply-To: <1526654878-11143-3-git-send-email-jacopo+renesas@jmondi.org>
References: <1526654878-11143-3-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <201805210704.sltVgyYq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacopo,

I love your patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[cannot apply to renesas/next v4.17-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jacopo-Mondi/arm64-dts-Draak-Enable-video-inputs-and-VIN4/20180521-052159
base:   git://linuxtv.org/media_tree.git master
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/renesas/r8a77995-draak.dts:272.1-6 Label or path vin4 not found
>> FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37440 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180521/60417e5b/attachment-0001.gz>

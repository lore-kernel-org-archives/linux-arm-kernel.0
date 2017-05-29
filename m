From: lkp@intel.com (kbuild test robot)
Date: Tue, 30 May 2017 03:09:56 +0800
Subject: [PATCH v2 3/4] arm64: dts: mt7622: add dts file for MT7622
 reference board variant 1
In-Reply-To: <83844be0407c4db170235c52f013b20a729e3382.1496061587.git.sean.wang@mediatek.com>
Message-ID: <201705300322.AIq7pz7X%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.12-rc3 next-20170529]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/sean-wang-mediatek-com/Add-Basic-SoC-support-for-MT7622/20170529-210756
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the linux-review/sean-wang-mediatek-com/Add-Basic-SoC-support-for-MT7622/20170529-210756 HEAD c1f5996a1eaf50f9b321fe8c6cddbf24d4969703 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> ERROR: Input tree has errors, aborting (use -f to force output)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34622 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170530/8d04e537/attachment-0001.gz>

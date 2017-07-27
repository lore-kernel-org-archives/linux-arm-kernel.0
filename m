From: lkp@intel.com (kbuild test robot)
Date: Thu, 27 Jul 2017 14:47:10 +0800
Subject: [PATCH v2 1/5] arm64: tegra: Add BPMP thermal sensor to Tegra186
In-Reply-To: <20170724162918.21050-1-mperttunen@nvidia.com>
Message-ID: <201707271402.PznRxqSc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mikko,

[auto build test ERROR on tegra/for-next]
[also build test ERROR on v4.13-rc2 next-20170726]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mikko-Perttunen/arm64-tegra-Add-BPMP-thermal-sensor-to-Tegra186/20170726-055759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
config: arm64-allnoconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the linux-review/Mikko-Perttunen/arm64-tegra-Add-BPMP-thermal-sensor-to-Tegra186/20170726-055759 HEAD 2aebe2225f7f5f03abf6098e07387fa011ec16a8 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi:1:0,
                    from arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts:5:
>> arch/arm64/boot/dts/nvidia/tegra186.dtsi:7:55: fatal error: dt-bindings/thermal/tegra186-bpmp-thermal.h: No such file or directory
    #include <dt-bindings/thermal/tegra186-bpmp-thermal.h>
                                                          ^
   compilation terminated.

vim +7 arch/arm64/boot/dts/nvidia/tegra186.dtsi

   > 7	#include <dt-bindings/thermal/tegra186-bpmp-thermal.h>
     8	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6558 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170727/32ea9f58/attachment.gz>

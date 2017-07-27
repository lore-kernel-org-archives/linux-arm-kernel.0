From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 27 Jul 2017 09:52:10 +0300
Subject: [PATCH v2 1/5] arm64: tegra: Add BPMP thermal sensor to Tegra186
In-Reply-To: <201707271402.PznRxqSc%fengguang.wu@intel.com>
References: <201707271402.PznRxqSc%fengguang.wu@intel.com>
Message-ID: <0f9e5f15-c4e2-d897-df3e-5253c3b94007@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good point, so patches 1/5 and 2/5 should be swapped around.

Mikko

On 27.07.2017 09:47, kbuild test robot wrote:
> Hi Mikko,
>
> [auto build test ERROR on tegra/for-next]
> [also build test ERROR on v4.13-rc2 next-20170726]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Mikko-Perttunen/arm64-tegra-Add-BPMP-thermal-sensor-to-Tegra186/20170726-055759
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
> config: arm64-allnoconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
>
> Note: the linux-review/Mikko-Perttunen/arm64-tegra-Add-BPMP-thermal-sensor-to-Tegra186/20170726-055759 HEAD 2aebe2225f7f5f03abf6098e07387fa011ec16a8 builds fine.
>       It only hurts bisectibility.
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi:1:0,
>                     from arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts:5:
>>> arch/arm64/boot/dts/nvidia/tegra186.dtsi:7:55: fatal error: dt-bindings/thermal/tegra186-bpmp-thermal.h: No such file or directory
>     #include <dt-bindings/thermal/tegra186-bpmp-thermal.h>
>                                                           ^
>    compilation terminated.
>
> vim +7 arch/arm64/boot/dts/nvidia/tegra186.dtsi
>
>    > 7	#include <dt-bindings/thermal/tegra186-bpmp-thermal.h>
>      8	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>

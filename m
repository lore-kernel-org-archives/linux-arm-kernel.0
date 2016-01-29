From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Fri, 29 Jan 2016 09:27:46 +0100
Subject: [PATCH v2 5/5] arm64/perf: Extend event mask for ARMv8.1
In-Reply-To: <201601290124.q5BROUwL%fengguang.wu@intel.com>
References: <6251e3377ca5d109c1a38ecc07fed50d6cbf5c61.1453992560.git.jglauber@cavium.com>
 <201601290124.q5BROUwL%fengguang.wu@intel.com>
Message-ID: <20160129082746.GA13045@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 01:33:35AM +0800, kbuild test robot wrote:
> Hi Jan,
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on v4.5-rc1 next-20160128]
> [cannot apply to tip/perf/core]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Jan-Glauber/Cavium-ThunderX-PMU-support/20160128-225855
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
> config: arm-corgi_defconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/arm/kernel/perf_event_xscale.c: In function 'xscale_map_event':
> >> arch/arm/kernel/perf_event_xscale.c:360:9: error: too many arguments to function 'armpmu_map_event'
>      return armpmu_map_event(event, &xscale_perf_map,
>             ^

I forgot the arm32 parts of this patch. I'll resend this patch only, the
other patches don't touch arm32.

--Jan

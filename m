From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 26 Apr 2018 15:42:42 +0530
Subject: [PATCH V3 3/3] cpufreq: add suspend/resume support in Armada
 37xx DVFS driver
In-Reply-To: <201804261439.n2Ff25A0%fengguang.wu@intel.com>
References: <e98965068836e673ea826e8a03fd01e168fce3ed.1524561482.git.viresh.kumar@linaro.org>
 <201804261439.n2Ff25A0%fengguang.wu@intel.com>
Message-ID: <20180426101242.vaqdclizsnohoqr7@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26-04-18, 17:32, kbuild test robot wrote:
> Hi Miquel,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on v4.17-rc2 next-20180424]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Viresh-Kumar/cpufreq-dt-Allow-platforms-to-provide-suspend-resume-hooks/20180426-101030
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/cpufreq/armada-37xx-cpufreq.c: In function 'armada37xx_cpufreq_driver_init':
> >> drivers/cpufreq/armada-37xx-cpufreq.c:268:3: error: label 'put_clk' used but not defined
>       goto put_clk;
>       ^~~~

Fixed, thanks.

-- 
viresh

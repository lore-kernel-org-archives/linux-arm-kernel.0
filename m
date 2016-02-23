From: xuejiancheng@huawei.com (xuejiancheng)
Date: Tue, 23 Feb 2016 09:25:01 +0800
Subject: [PATCH v9 2/6] clk: hisilicon: add CRG driver for hi3519 soc
In-Reply-To: <201602221742.MKAlpbcd%fengguang.wu@intel.com>
References: <201602221742.MKAlpbcd%fengguang.wu@intel.com>
Message-ID: <56CBB4ED.304@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'll fix this warning in next version.

Other comments will be appreciated!

Thank you!

On 2016/2/22 18:01, kbuild test robot wrote:
> Hi Jiancheng,
> 
> [auto build test WARNING on clk/clk-next]
> [also build test WARNING on v4.5-rc5 next-20160222]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Jiancheng-Xue/ARM-hisi-Add-initial-support-including-clock-driver-for-Hi3519-soc/20160222-160736
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> config: xtensa-allyesconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=xtensa 
> 
> All warnings (new ones prefixed by >>):
> 
> warning: (COMMON_CLK_HI3519) selects RESET_HISI which has unmet direct dependencies (COMMON_CLK && ARCH_HISI)
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

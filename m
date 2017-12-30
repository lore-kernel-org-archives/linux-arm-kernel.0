From: van.freenix@gmail.com (Peng Fan)
Date: Sat, 30 Dec 2017 15:49:18 +0800
Subject: [PATCH] ARM: imx: introduce imx_l2c310_write_sec
In-Reply-To: <201712291710.oGgg0Sre%fengguang.wu@intel.com>
References: <1514453750-15479-1-git-send-email-peng.fan@nxp.com>
 <201712291710.oGgg0Sre%fengguang.wu@intel.com>
Message-ID: <20171230074917.GA19767@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 29, 2017 at 05:32:18PM +0800, kbuild test robot wrote:
>Hi Peng,
>
>Thank you for the patch! Yet something to improve:
>
>[auto build test ERROR on shawnguo/for-next]
>[also build test ERROR on v4.15-rc5 next-20171222]
>[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
>url:    https://github.com/0day-ci/linux/commits/Peng-Fan/ARM-imx-introduce-imx_l2c310_write_sec/20171229-150558
>base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
>config: arm-arm5 (attached as .config)
>compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
>reproduce:
>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # save the attached .config to linux build tree
>        make.cross ARCH=arm 
>
>All errors (new ones prefixed by >>):
>
>   arch/arm/mach-imx/system.o: In function `imx_l2c310_write_sec':
>>> system.c:(.text+0x44): undefined reference to `__arm_smccc_smc'

Thanks for the report. I should do compile test for ARMV4/5.

Thanks,
Peng.

>
>---
>0-DAY kernel test infrastructure                Open Source Technology Center
>https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 

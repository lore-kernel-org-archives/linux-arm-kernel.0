From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 5 Mar 2018 10:37:28 +0000
Subject: [PATCH 3/3] drivers: clk: Add ZynqMP clock driver
In-Reply-To: <201803031109.JhmyjZJJ%fengguang.wu@intel.com>
References: <1519856861-31384-4-git-send-email-jollys@xilinx.com>
 <201803031109.JhmyjZJJ%fengguang.wu@intel.com>
Message-ID: <eddd8944-77c4-1813-4bd0-b7aa1cb70574@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/03/18 03:32, kbuild test robot wrote:
> Hi Jolly,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on clk/clk-next]
> [also build test ERROR on v4.16-rc3 next-20180302]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Jolly-Shah/drivers-clk-Add-ZynqMp-clock-driver-support/20180303-063643
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> config: arm64-allmodconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/clk/zynqmp/pll.c:9:0:
>>> include/linux/clk/zynqmp.h:10:10: fatal error: linux/firmware/xilinx/zynqmp/firmware.h: No such file or directory
>     #include <linux/firmware/xilinx/zynqmp/firmware.h>
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Another reason to have the complete series together, for better review
and better build coverage.

-- 
Regards,
Sudeep

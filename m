From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Jul 2017 09:54:14 +0200
Subject: [PATCH 3/3] ARM: dts: iwg20m: Add MMCIF0 support
In-Reply-To: <201707130850.0py1QazG%fengguang.wu@intel.com>
References: <1499853805-5915-4-git-send-email-chris.paterson2@renesas.com>
 <201707130850.0py1QazG%fengguang.wu@intel.com>
Message-ID: <20170713075414.GF5580@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 08:25:56AM +0800, kbuild test robot wrote:
> Hi Chris,
> 
> [auto build test ERROR on renesas/next]
> [also build test ERROR on next-20170712]
> [cannot apply to v4.12]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Chris-Paterson/Add-MMCIF0-support-for-r8a7743-iwg20m/20170713-042814
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
> config: arm-at91_dt_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
> >> Error: arch/arm/boot/dts/r8a7743-iwg20m.dtsi:40.1-5 Label or path pfc not found
>    FATAL ERROR: Syntax error parsing input tree

This seems to be a false positive. The node in question is present in
the devel branch which is the base of these changes.

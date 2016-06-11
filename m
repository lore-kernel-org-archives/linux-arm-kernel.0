From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 11 Jun 2016 12:25:03 +0200
Subject: [PATCH 48/48] ARM: dts: at91: kizbox: switch to new
 pwm-atmel-tcb binding
In-Reply-To: <201606110839.HwBLqerx%fengguang.wu@intel.com>
References: <1465596231-21766-49-git-send-email-alexandre.belloni@free-electrons.com>
 <201606110839.HwBLqerx%fengguang.wu@intel.com>
Message-ID: <20160611102503.GG19050@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2016 at 08:14:13 +0800, kbuild test robot wrote :
> Hi,
> 
> [auto build test ERROR on at91/at91-next]
> [also build test ERROR on v4.7-rc2 next-20160609]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Alexandre-Belloni/ARM-at91-rework-Atmel-TCB-drivers/20160611-062134
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git at91-next
> config: arm-at91_dt_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
> >> Error: arch/arm/boot/dts/at91-kizbox.dts:54.5-15 syntax error
>    FATAL ERROR: Unable to parse input tree
> 

Ok, I'm not sure what happened, this is now fixed in my branch.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

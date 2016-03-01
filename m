From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Mar 2016 21:31:09 +0100
Subject: [PATCH 3/6] powerpc: rtc: provide rtc_class_ops directly
In-Reply-To: <201603020228.jios50eU%fengguang.wu@intel.com>
References: <201603020228.jios50eU%fengguang.wu@intel.com>
Message-ID: <43764978.ST0U01oqaW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 March 2016 02:37:14 kbuild test robot wrote:
> [auto build test ERROR on abelloni/rtc-next]
> [also build test ERROR on v4.5-rc6 next-20160301]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/rtc-generic-follow-up-for-COMPILE_TEST/20160302-011032
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
> config: powerpc-allnoconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/kernel/built-in.o: In function `rtc_generic_get_time':
> >> time.c:(.text+0x4c58): undefined reference to `rtc_valid_tm'
> 

I fixed up the powerpc and parisc patches now, will resend them
after getting some feedback on the overall approach.

	Arnd

From: olof@lixom.net (Olof Johansson)
Date: Sat, 18 Jun 2016 22:22:27 -0700
Subject: [GIT PULL] omap rcu and fiq fixes for v4.7 merge window
In-Reply-To: <20160617160754.GF22406@atomide.com>
References: <20160617160754.GF22406@atomide.com>
Message-ID: <20160619052227.GC11958@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 09:07:54AM -0700, Tony Lindgren wrote:
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fixes-rcu-fiq-signed
> 
> for you to fetch changes up to d279f7a7e95af6bb4b5eaea3527d1f85a28c5cf6:
> 
>   ARM: dts: am437x-sk-evm: Reduce i2c0 bus speed for tps65218 (2016-06-17 02:59:04 -0700)
> 
> ----------------------------------------------------------------
> Fixes for omaps for v4.7-rc cycle:
> 
> - Two boot warning fixes from the RCU tree that should have gotten
>   merged several weeks ago already but did not because of issues
>   with who merges them. Paul has now split the RCU warning fixes into
>   sets for various maintainers.
> 
> - Fix ams-delta FIQ regression caused by omap1 sparse IRQ changes
> 
> - Fix PM for omap3 boards using timer12 and gptimer, like the
>   original beagleboard
> 
> - Fix hangs on am437x-sk-evm by lowering the I2C bus speed

Merged, thanks!


-Olof

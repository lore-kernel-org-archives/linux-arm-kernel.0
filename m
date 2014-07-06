From: afaerber@suse.de (=?ISO-8859-1?Q?Andreas_F=E4rber?=)
Date: Sun, 06 Jul 2014 22:05:34 +0200
Subject: [GIT PULL] ARM: SoC fixes for 3.16-rc
In-Reply-To: <20140705194930.GA26880@quad.lixom.net>
References: <20140705194930.GA26880@quad.lixom.net>
Message-ID: <53B9AC0E.4090606@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

Am 05.07.2014 21:49, schrieb Olof Johansson:
> The following changes since commit 6c9d16178870315846faa1f59697b801e3fe0531:
> 
>   Merge tag 'at91-fixes' of git://github.com/at91linux/linux-at91 into fixes (2014-06-25 20:27:15 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus
> 
> for you to fetch changes up to bc6aa56680b07984dc1443ef1a5a1a0fac0e20be:
> 
>   MAINTAINERS: Add few more Keystone drivers (2014-07-04 21:53:13 -0700)
> 
> ----------------------------------------------------------------
> ARM: SoC fixes for 3.16-rc
> 
> This week's arm-soc fixes:
> 
> - A set of of OMAP patches that we had missed Tony's pull request of:
>   - Reset fix for am43xx
>   - Proper OPP table for omap5
>   - Fix for SoC detection of one of the DRA7 SoCs
>   - hwmod updates to get SATA and OCP to work on omap5 (drivers merged in 3.16)
>   - ... plus a handful of smaller fixes
> - sunxi needed to re-add machine specific restart code that was removed in
>   anticipation of a watchdog driver being merged for 3.16, and it didn't make
>   it in.
> - Marvell fixes for PCIe on SMP and a big-endian fix.
> - A trivial defconfig update to make my capri test board boot with
>   bcm_defconfig again.
> 
> ... and a couple of MAINTAINERS updates, one to claim new Keystone
> drivers that have been merged, and one to merge MXS and i.MX (both
> Freescale platforms).
[...]
> Santosh Shilimkar (1):
>       MAINTAINERS: Add few more Keystone drivers

All four of your new MAINTAINERS entries just merged are lacking the S
in your company name - "INSTRUMENT". ;) Looks like a copy&paste from an
already misspelled section?

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg

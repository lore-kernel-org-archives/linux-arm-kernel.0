From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Aug 2013 13:20:45 -0700
Subject: [GIT PULL] late ux500 changes for v3.12
In-Reply-To: <CACRpkdYOoG87uvgB5e4DdVJqrzFwOVRv6pgiUq2P-zz_gxPTCw@mail.gmail.com>
References: <CACRpkdYOoG87uvgB5e4DdVJqrzFwOVRv6pgiUq2P-zz_gxPTCw@mail.gmail.com>
Message-ID: <20130829202045.GN18542@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 23, 2013 at 03:14:05PM +0200, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> here is a late pull request for some cleanup for ux500 to be pulled
> into the next-soc branch (this is based on the same branch as the
> previous pull request for ux500-core).
> 
> Should be harmless: two fixes that would have gone into the -rc:s
> anyway, and a cleanout of totally unused code.
> 
> Please pull it in.
> 
> Yours,
> Linus Walleij
> 
> 
> The following changes since commit 0a429fd15ecb05d7d5fa8eb4adaff69c7a00984b:
> 
>   ARM: ux500: set coherent_dma_mask for dma40 (2013-08-19 22:49:25 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/ux500-core-for-arm-soc-2
> 
> for you to fetch changes up to 1e66a3da4f7d73c027200fb18bb452fbde17fbd7:
> 
>   ARM: ux500: fix up the I2C devices (2013-08-20 13:58:25 +0200)
> 
> ----------------------------------------------------------------
> Ux500 core changes for ARM SoC:
> - Cleanup from Julia Lawall
> - Clean out old pin definitions
> - Fix the I2C devices
> 
> ----------------------------------------------------------------
> Julia Lawall (1):
>       arch/arm/mach-ux500/cpu-db8500.c: Avoid using ARRAY_AND_SIZE(e)
> as a function argument

This is a pretty unusual patch subject, feel free to rename them in the future
when you apply patches.

I've merged this in under a late/all branch, which we'll send up lateish in the
merge window.


-Olof

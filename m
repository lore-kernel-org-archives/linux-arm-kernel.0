From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 16:06:28 -0800
Subject: [GIT PULL] plat-versatile clock.c and generic clkdev.h
In-Reply-To: <CACRpkdbJPPR8jADF1p++w60jZre3tpCAECsaqkzAk4-Y4+N-SA@mail.gmail.com>
References: <CACRpkdbJPPR8jADF1p++w60jZre3tpCAECsaqkzAk4-Y4+N-SA@mail.gmail.com>
Message-ID: <20160225000628.GA10126@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 10:15:33AM +0100, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> these are Stephen Boyds changes to remove a stale clock implementation
> and move to the generic clkdev.h that I queued at Arnd's request, it turns
> out I will not have any busines changing stuff in arch/arm/plat-versatile
> for this merge window (however a few changes around mach-*) so
> this can be pulled in separately.
> 
> Please pull this in!
> 
> Yours,
> Linus Walleij
> 
> 
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/plat-versatile-cleanup
> 
> for you to fetch changes up to 34d2f4d3a4d6a6b204ebfd12d1d2c159360d41a4:
> 
>   ARM: Use generic clkdev.h header (2016-02-10 09:22:35 +0100)

Merged into next/cleanup. Thanks!


-Olof

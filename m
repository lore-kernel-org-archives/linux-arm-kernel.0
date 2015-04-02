From: olof@lixom.net (Olof Johansson)
Date: Wed, 1 Apr 2015 17:59:23 -0700
Subject: [GIT PULL] at91: multiplatform for 4.1 #1
In-Reply-To: <1426785269-6484-1-git-send-email-nicolas.ferre@atmel.com>
References: <1426785269-6484-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150402005923.GN8137@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 06:14:29PM +0100, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> This is the real switch to multi-platform for AT91: after all the preparation
> work that has been done, here we are! And there's also an additional cleanup on
> top of that...
> I stacked this material on top of my previous "at91-cleanup3" tag that I had sent
> you earlier this week. As all my cleanup material is also on top of the fixes
> tags (that you already have), these patches are also adapted to match this
> state and avoid conflicts.
> So, you can have this tag in your "multiplatform" branch separated, like I did,
> or simply stacked on top or the AT91 cleanup material.
> 
> Thanks, best regards,
> 
> The following changes since commit 88c5544ab2240cf2a2dc87b5af9cd7990d06d028:
> 
>   Merge tag 'at91-cleanup3' into at91-4.1-multiplatform (2015-03-16 18:09:48 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-multiplatform
> 
> for you to fetch changes up to 1164f672d71ac103d85207b0453f3127c0efefb3:
> 
>   ARM: at91: drop AT91_TIMER_HZ (2015-03-19 16:37:45 +0100)
> 
> ----------------------------------------------------------------
> This is the multi-platform support for AT91:
> - reworked arch/arm/mach-at91/Kconfig and arch/arm/Kconfig to switch to
>   multi-platform
> - updated at91_dt_defconfig
> - continue the cleanup of unneeded files and code chunks

Nice! Merged.


-Olof

From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 Oct 2015 14:36:59 +0900
Subject: [GIT PULL] omap soc clean-up for v4.4 merge window
In-Reply-To: <20151024204209.GB892@atomide.com>
References: <20151024204209.GB892@atomide.com>
Message-ID: <20151026053659.GC4216@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 24, 2015 at 01:42:10PM -0700, Tony Lindgren wrote:
> The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:
> 
>   Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.4/soc-clean-up
> 
> for you to fetch changes up to ef4da0c1c8f3ca3e9dcf6936bf687a32cd62f293:
> 
>   Merge tag 'for-v4.4/omap-hwmod-cleanup-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v4.4/soc (2015-10-23 18:13:38 -0700)
> 
> ----------------------------------------------------------------
> Minimal omap SoC changes for v4.4 merge window. As we've spent quite a
> bit of time sorting out regressions for v4.3 and are very late with
> these, I've kept the changes down to minimum:
> 
> - A series of timer changes from Felipe Balbi to get us closer to
>   moving the remaining timer code into drivers
> 
> - A series of hwmod clean-up changes queued by Paul Walmsley
> 
> - SoC detection clean-up to use soc_is instead of cpu_is as CPU is
>   within the SoC and is confusing naming. The rest we can now change
>   along with the other clean-up

This is arriving a bit late, but I've merged it anyway since it's cleanup.
Hopefully we won't see much regressions from it during the -rc cycle.


-Olof

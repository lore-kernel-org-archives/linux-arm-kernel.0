From: olof@lixom.net (Olof Johansson)
Date: Mon, 17 Sep 2012 19:37:49 -0700
Subject: [GIT PULL] omap fixes for linux next for v3.7 merge window
In-Reply-To: <20120918022856.GN11762@atomide.com>
References: <20120918022856.GN11762@atomide.com>
Message-ID: <CAOesGMjadRQk0=DRZGvE6Lds4+ovFPMA3hQQZGYhe_GemEmycQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 17, 2012 at 7:28 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Arnd & Olof,
>
> Here is the fix for the twl-core compile on non-omap
> platforms and few other fixes.
>
> This will probably cause a minor merge conflicts with
> the led changes merged in the arm-soc next/drivers branch
> as both linux/leds.h and linux/platform_data/gpio-omap.h
> now need to be included.
>
> Regards,
>
> Tony
>
>
> The following changes since commit 68cb700c59fae6cd539c9dc1e9f2584f671935a0:
>
>   ARM: OMAP1: Move SoC specific headers from plat to mach for omap1 (2012-09-12 18:06:31 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/cleanup-fixes-for-v3.7

Thanks, pulled in on top of next/cleanup. We might have missed the
-next train for the day though.


-Olof

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Mar 2017 10:37:04 +0200
Subject: [GIT PULL] omap fixes for v4.11-rc cycle
In-Reply-To: <8286423674296161545@unknownmsgid>
References: <8286423674296161545@unknownmsgid>
Message-ID: <CAK8P3a007Hik3fLZH+Me0GcJ15VFgWZTeqn4wx+NwJgh-T3mrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 7:07 PM, Tony Lindgren <tony@atomide.com> wrote:
> The following changes since commit e24bce8fb4c26bd0d8eca74cbbee1ad049246be3:
>
>   Merge tag 'v4.11-rc1' into omap-for-v4.11/fixes (2017-03-06 08:37:53 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/fixes-rc4
>
> for you to fetch changes up to 351b7c490700747d1dba1b0a10fbfe3448d11c35:
>
>   ARM: omap2+: Revert omap-smp.c changes resetting CPU1 during boot (2017-03-27 10:10:42 -0700)
>
> ----------------------------------------------------------------
> Fixes for omaps for v4.11-rc cycle. The biggest fix is to stop doing
> unconditional reset of CPU1 as that caused a regression for cases with
> custom bootloader loaded code running on CPU1. The rest are just minor
> fixes for devices and one warning fix.

Pulled into fixes, thanks!

      Arnd

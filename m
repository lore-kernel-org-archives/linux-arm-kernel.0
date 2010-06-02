From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 2 Jun 2010 16:38:44 -0700
Subject: Pull request for nanoengine
In-Reply-To: <AANLkTilh4NtHS5p3tWbMtIU9MBBC-Md13Aw9_RdL3Ogp@mail.gmail.com>
References: <AANLkTilh4NtHS5p3tWbMtIU9MBBC-Md13Aw9_RdL3Ogp@mail.gmail.com>
Message-ID: <20100602163844.509e9953.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Jun 2010 20:19:01 -0300
Marcelo Roberto Jimenez <mroberto@cetuc.puc-rio.br> wrote:

> The following is a compilation of all the patches I have done for the
> nanoengine. Some of these are also valid for SA11xx based machines
> like, e.g, sharp Zaurus.

Which other kernel developer were you hoping would merge this tree?

>  arch/arm/configs/nanoengine_defconfig          | 1396 ++++++++++++++++++++++++
>  arch/arm/mach-sa1100/Kconfig                   |    8 +
>  arch/arm/mach-sa1100/Makefile                  |    2 +
>  arch/arm/mach-sa1100/cpu-sa1100.c              |   56 +-
>  arch/arm/mach-sa1100/cpu-sa1110.c              |   51 +-
>  arch/arm/mach-sa1100/include/mach/nanoengine.h |   30 +
>  arch/arm/mach-sa1100/nanoengine.c              |  115 ++
>  drivers/pcmcia/Makefile                        |    3 +-
>  drivers/pcmcia/sa1100_generic.c                |    3 +
>  drivers/pcmcia/sa1100_generic.h                |    1 +
>  drivers/pcmcia/sa1100_nanoengine.c             |  219 ++++
>  drivers/pcmcia/soc_common.c                    |  129 ++-
>  drivers/rtc/rtc-sa1100.c                       |  153 ++-

I can only think it must have been Russell.

I've rather lost track of what's happening with ARM subtrees.  I
_think_ it's now the case the relevant maintainers are putting their
trees into linux-next directly and are asking Linus to pull them
directly.  But maybe that's a misconception.

Can someone please explain the current state of play?

Thanks.

From: olof@lixom.net (Olof Johansson)
Date: Sun, 11 Dec 2011 18:10:40 -0800
Subject: [GIT PULL] PM support for omap4 for v3.3 merge window
In-Reply-To: <20111209212155.GZ31337@atomide.com>
References: <20111209212155.GZ31337@atomide.com>
Message-ID: <CAOesGMjCJpG7-t9dfnVkg7hh_1EqkK3FxxLvh7AU0xnp7Xz5vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2011 at 1:21 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Arnd & Olof,
>
> Please pull omap4 PM support from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap4
>
> Note that because of the map_io and common.h changes this is based
> on commit deee6d5359969a0ce4e2760cfd7b9f379bd5698a in Russell's
> devel-stable.
>
> FYI, other omap SoC related changes that I'll post later will have a
> build dependency to this series for the omap-secure.c changes.

Thanks, pulled into next/pm.


-Olof

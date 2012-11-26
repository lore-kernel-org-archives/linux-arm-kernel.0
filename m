From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 Nov 2012 01:35:22 -0800
Subject: [GIT PULL 4/5] ARM: orion: dt for v3.8
In-Reply-To: <50b056f6.c188e50a.1750.ffff84caSMTPIN_ADDED_MISSING@mx.google.com>
References: <pull-1353733874-990435>
 <50b056f6.c188e50a.1750.ffff84caSMTPIN_ADDED_MISSING@mx.google.com>
Message-ID: <20121126093522.GE13866@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 24, 2012 at 05:11:11AM +0000, Jason Cooper wrote:
> The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:
> 
>   Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/orion_dt_for_3.8
> 
> for you to fetch changes up to 2a18588c0ce336933be3c99c91e74e21db56a0fe:
> 
>   ARM: Kirkwood: remove kirkwood_ehci_init() from new boards (2012-11-24 03:58:12 +0000)
> 
> ----------------------------------------------------------------
> orion dt for v3.8
> 
>  - ehci-orion dt binding
>  - gpio-poweroff
>  - use dt regulators
>  - move mpp to DT/pinctrl

> 
> Depends on:
> 
>  - orion/boards
> 
>     - merge conflicts
>        - keep all 'select's in Kconfig
>        - remove all #includes in board-*.c
> 
>  - pinctrl/devel up to:
> 
>     - 06763c7 pinctrl: mvebu: move to its own directory

By the way, this branch ended up having conflicts against the cleanup branch.
It'd be nice to avoid those by basing your later topics on the cleanups if
needed.

It was mostly remove/remove conflicts of header files, and not a big deal to
handle for us, but if by slight tweaks to branch organization at your level you
can avoid some of them for us.

Some conflicts are still of course OK -- just like Linus prefers to see them,
we don't mind either. But some of the internal ones between different branches
from the same maintainer are sometimes a bit more than we care for. :)

-Olof

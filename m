From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Aug 2017 22:56:46 +0200
Subject: [GIT PULL] device tree changes for omaps for v4.14, part2
In-Reply-To: <-4579924122609271736@unknownmsgid>
References: <-4579924122609271736@unknownmsgid>
Message-ID: <CAK8P3a3pFcE79fMMX1fkj_H3=_2xORK7xKARpWTQszok43FTOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 8:28 PM, Tony Lindgren <tony@atomide.com> wrote:
> ----------------------------------------------------------------
> Second set of device tree changes for omaps for v4.14 merge window.
> These got delayed a bit because the iodelay changes had to be
> reworked for a missing Signed-off-by. And the beagleboard-x15
> wants to use iodelay too for mmc:
>
> - A series of changes to add dra7 iodelay data used for mmc
>
> - Add support for new beagleBoard-x15 revision c
>
> - Fix logicpd-torpedo-37xx-devkit mmc card detect direction

Pulled into next/dt, thanks!

       Arnd

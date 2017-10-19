From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Oct 2017 00:44:44 +0200
Subject: [GIT PULL 2/2] more soc changes for omaps for v4.15 merge window
In-Reply-To: <pull-1508450284-272943@atomide.com-2>
References: <pull-1508450284-272943@atomide.com>
 <pull-1508450284-272943@atomide.com-2>
Message-ID: <CAK8P3a17tvVSuzarT_M9jrVVsdqNp5CZFgdZz3uhdYK8+R3QqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 11:59 PM, Tony Lindgren <tony@atomide.com> wrote:
> Drop omap legacy platform data for IRQ, DMA and IO resources. With the
> dts files fixed up to contain the necessary data for basic resources, we
> can drop the related platform data.
>
> Note that this branch depends on the "omap-for-v4.15/fixes-dt-signed"
> branch and the patches with dependencies are based on a merge with that
> branch.
>
> These patches first ensure things keep working for the legacy "ti,hwmods"
> property when we start making it optional, then adds a minimal TI sysc
> interconnect target device driver to handle the new generic "ti,sysc"
> compatible property. And then we can finally drop the legacy platform
> data for IRQ, DMA and IO resources as seen in the diffstats.

Nice!

Pulled into next/soc, thanks!

       Arnd

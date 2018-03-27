From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Mar 2018 13:11:45 +0200
Subject: [GIT PULL] v2 of two omap fixes for v4.16-rc cycle
In-Reply-To: <pull-1521736922-590596@atomide.com>
References: <pull-1521736922-590596@atomide.com>
Message-ID: <CAK8P3a2sm_0nYBA05pf=FrHhKz_YY0uPXtL0sG2Q4K5b5y45Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2018 at 5:42 PM, Tony Lindgren <tony@atomide.com> wrote:
> Two fixes for omap variants for v4.16-rc cycle
>
> Fix insecure W+X mapping warning for SRAM for omaps that
> don't yet use drivers/misc/*sram*.c code. An earlier attempt
> at fixing this turned out to cause problems with PM on omap3,
> this version works with PM on omap3.
>
> Also fix dmtimer probe for omap16xx devices that was noticed
> with the pending dmtimer move to drivers. It seems this has
> been broken for a while and is a non-critical for booting.
> It is needed for PM on omap16xx though.
>

Pulled into fixes, thanks!

      Arnd

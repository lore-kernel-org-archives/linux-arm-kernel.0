From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Oct 2017 00:36:02 +0200
Subject: [GIT PULL 1/2] non-urgent device tree fixes for omaps for v4.15
 merge window
In-Reply-To: <pull-1508450284-272943@atomide.com>
References: <pull-1508450284-272943@atomide.com>
Message-ID: <CAK8P3a2fDBZeuQOfucMcx0_eFiyMLoT2YdqOZmzaGV8DkBvoCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 11:59 PM, Tony Lindgren <tony@atomide.com> wrote:
> Non-urgent device tree fixes for omaps that can all wait for v4.15
> merge window.
>
> Turns out that we have many devices working just because we have
> the legacy platform data still around. This is mostly an issue
> for omap4, other SoCs just have minimal fixes needed.
>
> As many of the missing device tree nodes and properties are for
> devices that have no drivers in the mainline kernel, such as
> slimbus, iss, mcasp, aess, fdif and gpu, we might as well start
> using the new "ti,sysc" interconnect target module binding for
> them so we can get the devices with no child device drivers idled.
>
> This also makes it possible to drop unnecessary platform data
> in later patches.

Pulled into next/dt, thanks!

        Arnd

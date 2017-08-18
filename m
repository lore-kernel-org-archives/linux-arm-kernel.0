From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 19 Aug 2017 00:08:53 +0200
Subject: [GIT PULL] non-urgent fixes for omaps for v4.14
In-Reply-To: <-7291673037985203159@unknownmsgid>
References: <-7291673037985203159@unknownmsgid>
Message-ID: <CAK8P3a0WDkzUwLz2ZUQdGrOX0oW+gvGgF3zyktum==OqvCmUpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 7:50 PM, Tony Lindgren <tony@atomide.com> wrote:
> Non-urgent fixes for omaps for v4.14 merge window. These all
> can wait for the merge window as we have not seemed to hit
> any of these so far:
>
> - Fix error handling in omap_ocp2scp_probe affecting runtime
>   PM error path
>
> - Drop broken RPM status update for omap_device
>
> - Two fixes for of_irq_get() usage that can return 0

Pulled into next/cleanup, thanks!

       Arnd

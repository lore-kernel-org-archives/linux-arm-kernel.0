From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 22:46:12 +0200
Subject: [GIT PULL 1/2] soc changes for omaps for v4.15 merge window
In-Reply-To: <pull-1507912705-793554@atomide.com>
References: <pull-1507912705-793554@atomide.com>
Message-ID: <CAK8P3a0gfs2GQVKEiiSAHgJSBywi5CNeNHHz=jcyM+fbp6LHvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 6:39 PM, Tony Lindgren <tony@atomide.com> wrote:
> SoC changes for omaps for v4.15 merge window that are mostly non-urgent
> fixes and clean-up in preparation for dropping more platform data later
> on:
>
> - Fix am33xx/am437x MMC address space offsets
>
> - Fix overwriting clkctrl and modulemode values when dts data is
>   used
>
> - Drop unused platform init code for omap_init_hdq
>
> - Drop unused struct omap_hwmod_mux_info
>
> - Remove duplicate define for dra722 es1.0 silicon revision
>
> - Add support for dra71x es2.1
>
> - Make omap_dma_dev_info __initdata
>
> - A series of fixes for Coccinelle found issues

Pulled into next/soc, thanks!

       Arnd

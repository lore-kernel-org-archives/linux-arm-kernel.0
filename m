From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Jan 2018 12:37:46 +0100
Subject: [GIT PULL] dts driver fixes for omaps for v4.16 merge window
In-Reply-To: <pull-1516376193-270253@atomide.com>
References: <pull-1516376193-270253@atomide.com>
Message-ID: <CAK8P3a2jjpo0R8iQPd+HP-e20Pe2BC9pBbWsoTpXVDanKfffNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 19, 2018 at 4:38 PM, Tony Lindgren <tony@atomide.com> wrote:
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit 80a06c0d8357d1e75a8fbc10813fcdada4d897fb:
>
>   ARM: dts: dm816x: add clkctrl nodes (2017-12-11 08:28:37 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/dt-clk-dts-signed
>
> for you to fetch changes up to e14d7e5320ebae9bffe4fbd585dfdd9d6de2550f:
>
>   ARM: dts: Update ti-sysc data for existing users (2018-01-12 15:16:57 -0800)
>
> ----------------------------------------------------------------
> Few omap interconnect dts fixes for v4.16 merge window
>
> Now that we have the dts clocks for the clkctrl clock and the
> interconnect binding, we need to update the existing ti-sysc
> users according to the binding to make it usable for drivers.
>
> Apologies for not being able to send this earlier but it took
> me few revisions to get the smartreflex changes right and
> tested with yet to be posted patches to make smartreflex probe
> with dts and I wanted to have it sit in next for a while to make
> sure we're not introducing regressions for legacy platform data
> based booting.
>
> Note that this is based on a merge with commit 20a2742e5784
> ("dt-bindings: ti-sysc: Update binding for timers and capabilities")
> to avoid a merge conflict with the binding changes.

Pulled into next/dt, thanks!

       Arnd

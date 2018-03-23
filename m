From: horms@verge.net.au (Simon Horman)
Date: Fri, 23 Mar 2018 09:58:40 +0100
Subject: [PATCH v2 1/4] arm64: dts: renesas: r8a7795: sort subnodes of
 the root node
In-Reply-To: <CAMuHMdVng6MvW5meEjx_FYttvyDytOh9d17zZMja8LoefUDZ5Q@mail.gmail.com>
References: <20180322102423.18269-1-horms+renesas@verge.net.au>
 <20180322102423.18269-2-horms+renesas@verge.net.au>
 <CAMuHMdVng6MvW5meEjx_FYttvyDytOh9d17zZMja8LoefUDZ5Q@mail.gmail.com>
Message-ID: <20180323085837.tuvfxatqsiysvu4g@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2018 at 09:36:16AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Mar 22, 2018 at 11:24 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Sort subnodes of the root node alphanumerically.
> >
> > This is part of an ongoing effort to provide consistent node
> > order in the DT of Renesas SoCs to improve maintainability.
> >
> > This should not have any run-time effect.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > v2
> > * Also sort clock nodes
> 
> Thanks for the update!
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> using "grep '{' | grep -v @", which tells me
>   - clusterX_opp should be before cpus,
>   - thermal_zones should be before timer.

Thanks, I will fix that in v3.

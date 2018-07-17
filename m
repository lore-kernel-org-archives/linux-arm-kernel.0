From: horms@verge.net.au (Simon Horman)
Date: Tue, 17 Jul 2018 14:19:25 +0200
Subject: [PATCH v4] arm64: dts: r8a77995: Add SCIF {0,1,3,4,5} and all
 HSCIF device nodes
In-Reply-To: <CAMuHMdXZ_pQaF7BZs_F6MdYsacRDHmNLnUS14n5yhy9+r6Z5Mw@mail.gmail.com>
References: <20180717113832.26413-1-horms+renesas@verge.net.au>
 <CAMuHMdXZ_pQaF7BZs_F6MdYsacRDHmNLnUS14n5yhy9+r6Z5Mw@mail.gmail.com>
Message-ID: <20180717121924.42ilbf4l6ryksmap@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 01:45:26PM +0200, Geert Uytterhoeven wrote:
> On Tue, Jul 17, 2018 at 1:38 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> >
> > This patch adds the device nodes for SCIF {0,1,3,4,5} and all HSCIF serial
> > ports, incl. clocks, power domain and DMAs.
> >
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > --
> > v3 [Simon Horman]
> > * Add DMAs
> 
> For the newly added SCIF dmas:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied.

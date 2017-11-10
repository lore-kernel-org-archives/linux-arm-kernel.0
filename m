From: horms@verge.net.au (Simon Horman)
Date: Fri, 10 Nov 2017 13:07:50 +0100
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77995: Add IPMMU device nodes
In-Reply-To: <CAMuHMdVS_5_iouNei_HvgUtWTVS_NuLcbpua_K_VUQqr7Pt_QA@mail.gmail.com>
References: <20171101103508.7721-1-horms+renesas@verge.net.au>
 <20171101103508.7721-2-horms+renesas@verge.net.au>
 <CAMuHMdVS_5_iouNei_HvgUtWTVS_NuLcbpua_K_VUQqr7Pt_QA@mail.gmail.com>
Message-ID: <20171110120749.rbh7dzknbaatrqjb@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 11:13:36AM +0100, Geert Uytterhoeven wrote:
> On Wed, Nov 1, 2017 at 11:35 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Add r8a77995 IPMMU nodes and keep all disabled by default.
> >
> > Based on work for the r8a7795 and r8a7796 by Magnus Damm
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> My comment for r8a7795.dtsi about IPMMU-* comments is applicable here, too.

Thanks, I will drop those comments.

> My comment about power-domains properties probably isn't, as R-Car D3
> doesn't have I/O power domains, which table 16.2 doesn't take into account.

Thanks, I will not add power domains at this time.

From: horms@verge.net.au (Simon Horman)
Date: Fri, 25 Mar 2016 09:33:36 +0900
Subject: [PATCH 0/3] ARM, arm64: dts: Use USB3.0 fallback compatibility
 strings
In-Reply-To: <CAMuHMdVfRH=U+sANGo_=2TazKQ3ePvZbYR8WAAWuewXCRRXzkw@mail.gmail.com>
References: <1458784869-17829-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVfRH=U+sANGo_=2TazKQ3ePvZbYR8WAAWuewXCRRXzkw@mail.gmail.com>
Message-ID: <20160325003335.GD24822@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 12:08:03PM +0100, Geert Uytterhoeven wrote:
> On Thu, Mar 24, 2016 at 3:01 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Use recently added fallback compatibility strings in r8a779[015] device
> > trees.
> >
> > Based on renesas-devel-20160323-v4.5
> >
> > Simon Horman (3):
> >   ARM: dts: r8a7790: Use USB3.0 fallback compatibility string
> >   ARM: dts: r8a7791: Use USB3.0 fallback compatibility string
> >   arm64: dts: r8a7795: Use USB3.0 fallback compatibility string
> >
> >  arch/arm/boot/dts/r8a7790.dtsi           | 2 +-
> >  arch/arm/boot/dts/r8a7791.dtsi           | 2 +-
> >  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 4 ++--
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> For the whole series:
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.

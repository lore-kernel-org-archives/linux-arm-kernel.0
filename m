From: horms@verge.net.au (Simon Horman)
Date: Mon, 26 Feb 2018 12:03:08 +0100
Subject: [PATCH] arm64: defconfig: enable R8A77965 SoC
In-Reply-To: <CAMuHMdXg1qYsS8H1EQ+rs9r2uibtraYv9jhgrzO=mBpSx5D0vA@mail.gmail.com>
References: <20180223085115.13782-1-horms+renesas@verge.net.au>
 <CAMuHMdVsOzXz+pU_7bDaQgs371zozy6Za8eDDiauV8qu03ckmw@mail.gmail.com>
 <20180223150023.f2pf3afpcckbskme@verge.net.au>
 <CAMuHMdXg1qYsS8H1EQ+rs9r2uibtraYv9jhgrzO=mBpSx5D0vA@mail.gmail.com>
Message-ID: <20180226110308.q5ywc5kxhpn5e2fr@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 09:23:33AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Feb 23, 2018 at 4:00 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Feb 23, 2018 at 10:19:45AM +0100, Geert Uytterhoeven wrote:
> >> On Fri, Feb 23, 2018 at 9:51 AM, Simon Horman
> >> <horms+renesas@verge.net.au> wrote:
> >> > Enable the Renesas R-Car M3-W (R8A77965) SoC in the ARM64 defconfig.
> >> >
> >> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >>
> >> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > I have applied this to the topic/renesas-defconfig branch which is included
> > in the devel branch and tags of the Renesas tree as a convenience to
> > developers.  The branch is not, however, included in the next branch or
> > tags nor is it targeted at upstream.
> 
> Looks like it accidentally ended up in your next branch.
> 
> Merge report from sfr:
> 
> Merging renesas/next (60d04a4b6d41 Merge branch
> 'topic/renesas-defconfig' into next)

Yes, indeed. I'll fix that.

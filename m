From: horms@verge.net.au (Simon Horman)
Date: Tue, 24 Nov 2015 11:30:25 +0900
Subject: [PATCH v6 00/12] arm64: renesas: add sound support
In-Reply-To: <20151110001111.GB1040@verge.net.au>
References: <87egg3k5g6.wl%kuninori.morimoto.gx@renesas.com>
 <20151109012943.GF4832@verge.net.au>
 <CAMuHMdXBQNCibJU4EDuFZX0zRzUZfC_4KTyXFNVLL81a51Q4RA@mail.gmail.com>
 <20151109090139.GM4832@verge.net.au>
 <CAMuHMdWv1Ae1JTDyN2JkuHC1Fmfw25gtmmUkSMUitrUQnv82Ug@mail.gmail.com>
 <20151110001111.GB1040@verge.net.au>
Message-ID: <20151124023025.GA21853@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Morimoto-san,

On Tue, Nov 10, 2015 at 09:11:12AM +0900, Simon Horman wrote:
> On Mon, Nov 09, 2015 at 10:07:20AM +0100, Geert Uytterhoeven wrote:
> > Hi Simon,
> > 
> > On Mon, Nov 9, 2015 at 10:01 AM, Simon Horman <horms@verge.net.au> wrote:
> > > On Mon, Nov 09, 2015 at 09:08:08AM +0100, Geert Uytterhoeven wrote:
> > >> On Mon, Nov 9, 2015 at 2:29 AM, Simon Horman <horms@verge.net.au> wrote:
> > >> >>       arm64: renesas: salvator-x: Sound SSI PIO support
> > >> >
> > >> > The above patch seemed to have some fuzz. Please check that
> > >> > I resolved that correctly.
> > >>
> > >> The ak4613 node is now a child node of scif2 instead of i2c2, which is
> > >> definitely not correct.
> > >>
> > >> "git diff topic/r8a7795-sound-v5..topic/r8a7795-sound-v6" will show you.
> > >
> > > Thanks, that is a bit of a disaster. Sorry about that.
> > >
> > > I have tried to fix the problem and re-pushed topic/r8a7795-sound-v6.
> > > The head commit is now:
> > >
> > > 03a185979391 ("arm64: defconfig: add Renesas sound and AK4613 support")
> > 
> > Thanks, looks much better now.
> 
> Thanks for checking.

I am wondering if it is appropriate to queue up this series for v4.5.
Could you let me know what your thoughts on that are?

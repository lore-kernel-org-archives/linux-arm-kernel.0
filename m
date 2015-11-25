From: horms@verge.net.au (Simon Horman)
Date: Wed, 25 Nov 2015 17:44:26 +0900
Subject: [PATCH v6 00/12] arm64: renesas: add sound support
In-Reply-To: <87610q8upv.wl%kuninori.morimoto.gx@renesas.com>
References: <87egg3k5g6.wl%kuninori.morimoto.gx@renesas.com>
 <20151109012943.GF4832@verge.net.au>
 <CAMuHMdXBQNCibJU4EDuFZX0zRzUZfC_4KTyXFNVLL81a51Q4RA@mail.gmail.com>
 <20151109090139.GM4832@verge.net.au>
 <CAMuHMdWv1Ae1JTDyN2JkuHC1Fmfw25gtmmUkSMUitrUQnv82Ug@mail.gmail.com>
 <20151110001111.GB1040@verge.net.au>
 <20151124023025.GA21853@verge.net.au>
 <87k2p7yjbl.wl%kuninori.morimoto.gx@renesas.com>
 <20151125002752.GH20596@verge.net.au>
 <87610q8upv.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20151125084422.GA11664@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 06:27:30AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> Cc Geert
> 
> > > I would like to check latest version.
> > > Which branch/tag can I check ?
> > 
> > If you want to check for apply-time and compile-time dependencies use
> > the latest renesas-devel tag in my renesas tree.
> > 
> > If you want to check run-time you may need to pull in some dependencies,
> > especially the cpg-mssr-v6 branch of Geert's renesas-drivers tree.  A
> > sledge-hammer approach would be to pull in the latest renesas-drivers tag
> > of that tree.
> > 
> > In any case I'll need to know what run-time dependencies, other than
> > cpg-mssr, are missing from renesas-next and/or renesas-devel so we can
> > sensibly decide what to queue up.
> 
> Recent renesas-drivers sound has many conflicts, and sound
> has strange behavior. I had tried it before and noticed.
> I'm not sure latest one, but it has conflict log.
> I'm using a littile older kernel, because of above reason.

:(

> Anyway, I tried below, and I could get sound.
> (Limited sound only, because we are lacking CS2000 driver)
> 
> 	> git checkout renesas-devel-20151123-v4.4-rc2
> 	> git merge geert/topic/cpg-mssr-v6
>         > git am -3 ${PATCH-SET}
> 
> I will send ${PATCH-SET} soon

>From my POV this is a good result.

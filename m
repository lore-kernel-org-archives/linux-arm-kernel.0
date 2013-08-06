From: horms@verge.net.au (Simon Horman)
Date: Tue, 6 Aug 2013 17:37:55 +0900
Subject: [PATCH 0/2] ARM: shmobile: remove nfsroot settings
In-Reply-To: <uzjsvrzs5.wl%kuninori.morimoto.gx@renesas.com>
References: <87bo5h3lb3.wl%kuninori.morimoto.gx@renesas.com>
 <20130801080226.GF15265@verge.net.au>
 <20130806010736.GA20940@verge.net.au>
 <87r4e7h88z.wl%kuninori.morimoto.gx@renesas.com>
 <20130806022955.GA25114@verge.net.au>
 <87pptrh6f3.wl%kuninori.morimoto.gx@renesas.com>
 <87ob9bh5mt.wl%kuninori.morimoto.gx@renesas.com>
 <87haf3gxg6.wl%kuninori.morimoto.gx@renesas.com>
 <20130806082333.GA10748@verge.net.au>
 <uzjsvrzs5.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20130806083753.GA28493@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 05:26:06PM +0900, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > > > Yes, I can send patches.
> > > > > But, I can't test emev2-kzm9d board.
> > > > > Do you have it ?
> > > > 
> > > > These patches remove nfsroot settings from kzm9d/armadillo dts file.
> > > > I tested #1 patch on Armadillo board, but I don't have kzm9d board.
> > > 
> > > I could test kzm9d board on Magnus's environment.
> > > It works well without "rsize/wsize"
> > 
> > Thanks, I will test Armadillo.
> 
> Thank you.
> But I already tested it on Armadillo :)
> It works well

Great!

I will queue these changes up for v3.12 in the cleanup3 branch.

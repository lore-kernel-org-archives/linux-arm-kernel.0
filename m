From: horms@verge.net.au (Simon Horman)
Date: Thu, 26 Nov 2015 11:22:19 +0900
Subject: [PATCH 0/12] arm64: renesas: r8a7795: sound support
In-Reply-To: <8737vu8ucv.wl%kuninori.morimoto.gx@renesas.com>
References: <8737vu8ucv.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20151126022215.GB30297@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 06:35:17AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> These are r8a7795/salvator-x sound support for latest branch.
> (These are posted few month ago and were queued on Simon's branch)
> 
> I could have sound by this order
> 
> 	> git checkout renesas-devel-20151123-v4.4-rc2
> 	> git merge  geert/topic/cpg-mssr-v6
> 	> git am -3 ${THESE-PATCH-SET}
> 
> These supports 44.1kHz sound only. 48kHz sound needs cs2000 driver
> which is posted to ML (clk maintainer accepted ?)
> I can send cs2000 support if it was accepted.

Thanks Morimoto-san,

I have queued this up for v4.5.

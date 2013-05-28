From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 May 2013 07:52:30 -0400
Subject: [GIT PULL] ARM: mvebu: fixes for v3.10 (round 3)
In-Reply-To: <20130528023158.GB13532@quad.lixom.net>
References: <20130527185436.GN31290@titan.lakedaemon.net>
 <20130528023158.GB13532@quad.lixom.net>
Message-ID: <20130528115230.GQ31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 27, 2013 at 07:31:58PM -0700, Olof Johansson wrote:
> Hi,
> 
> On Mon, May 27, 2013 at 02:54:36PM -0400, Jason Cooper wrote:
> 
> > Thomas Petazzoni (2):
> >       arm: mvebu: fix length of SATA registers area in .dtsi
> >       arm: mvebu: fix length of Ethernet registers area in .dtsi
> 
> Is this an actual regression in 3.10?

Nope, it's just wrong.  :)

> I can understand having to fix this before the static mapping is removed,
> but if it's still there for 3.10, then it makes more sense to queue these
> fixes for 3.11 (we tend to collect a "fixes-non-critical" that is merged
> before any other branches in the next merge window).

ok, please drop this PR, I'll rework this and submit fresh ones.

thx,

Jason.

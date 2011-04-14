From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 14 Apr 2011 15:00:49 +0100
Subject: [PATCH 0/2] Common struct clk implementation, v14
In-Reply-To: <alpine.LFD.2.00.1104140920110.24613@xanadu.home>
References: <1299134429.100626.661279191478.0.gpush@pororo>
	<1302754859.2767.30.camel@pororo>
	<20110414100048.GB1611@n2100.arm.linux.org.uk>
	<1302776705.28876.113.camel@pasglop>
	<20110414103200.GF1611@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104140751220.24613@xanadu.home>
	<20110414120904.GH1611@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104140920110.24613@xanadu.home>
Message-ID: <20110414140048.GB1452@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2011 at 09:39:58AM -0400, Nicolas Pitre wrote:
> On Thu, 14 Apr 2011, Russell King - ARM Linux wrote:

> > Adding it without anyone using it doesn't solve anything.  We need
> > people to commit to producing patches to use it for the next merge
> > window.

> People are simply waiting for the API to hit some upstream tree (like 
> yours) before committing to it.  You would be in a much better position 
> if those patches are in your tree, so that you can tell people: "Here's 
> the Git branch with the API in it, so now I'm expecting patches to 
> convert clock users to it".

One way of doing this would be to apply the patches to a branch in your
tree which isn't merged into -next and request that architecture
maintainers wishing to make use of the branch pull it into their trees.
That way it'll go into -next with at least one user but multiple
architectures can still work on using it in the initial merge.

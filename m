From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Mon, 25 Apr 2016 14:02:22 +0200
Subject: [PATCH v2 0/5] Cavium ThunderX uncore PMU support
In-Reply-To: <20160425112207.GL16065@arm.com>
References: <cover.1457539621.git.jglauber@cavium.com>
 <20160404121954.GA9300@hardcore> <20160425112207.GL16065@arm.com>
Message-ID: <20160425120222.GA2552@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Mon, Apr 25, 2016 at 12:22:07PM +0100, Will Deacon wrote:
> Hi Jan,
> 
> On Mon, Apr 04, 2016 at 02:19:54PM +0200, Jan Glauber wrote:
> > Hi Mark,
> > 
> > can you have a look at these patches?
> 
> Looks like Mark reviewed this last week -- are you planning to respin?
> 
> Will

Yes, of course. I just had no time yet and I'm a bit lost on how to
proceed without using the NUMA node information which Mark did not like
to be used.

The only way to know which device is on which node would be to look
at the PCI topology (which is also the source of the NUMA node_id).
We could do this manually in order to not depend on CONFIG_NUMA,
but I would like to know if that is acceptable before respinning the
patches.

Thanks!
Jan

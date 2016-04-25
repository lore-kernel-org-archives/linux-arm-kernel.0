From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Apr 2016 12:19:38 +0100
Subject: [PATCH] make dt_scan_depth1_nodes more readable
In-Reply-To: <alpine.DEB.2.10.1604251204380.24872@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1604251121590.4855@sstabellini-ThinkPad-X260>
 <20160425105340.GE16065@arm.com>
 <alpine.DEB.2.10.1604251204380.24872@sstabellini-ThinkPad-X260>
Message-ID: <20160425111938.GK16065@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 12:04:53PM +0100, Stefano Stabellini wrote:
> On Mon, 25 Apr 2016, Will Deacon wrote:
> > On Mon, Apr 25, 2016 at 11:25:11AM +0100, Stefano Stabellini wrote:
> > > From: Mark Rutland <mark.rutland@arm.com>
> > > 
> > > Improve the readability of dt_scan_depth1_nodes by removing the nested
> > > conditionals.
> > > 
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> > > 
> > > ---
> > > 
> > > Note: this patch is based on xentip/for-linus-4.7
> > 
> > So how should I merge it? :/
> 
> I think that if you would like to merge it, it would be easier this time
> for me to carry it in my tree. Otherwise you would have to base your
> for-linus-4.7 on xentip/for-linus-4.7 and send the pull request after
> the Xen pull request -- undesirable.

Ok, doesn't look like we'll run into conflicts. I just find it weird that
you'd have a patch with no functional change as a dependency, hence my
preference to queue it in the arm64 tree (where conflicts are more likely).

Will

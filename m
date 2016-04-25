From: sstabellini@kernel.org (Stefano Stabellini)
Date: Mon, 25 Apr 2016 13:56:56 +0100 (BST)
Subject: [PATCH] make dt_scan_depth1_nodes more readable
In-Reply-To: <20160425125440.GN16065@arm.com>
References: <alpine.DEB.2.10.1604251121590.4855@sstabellini-ThinkPad-X260>
 <20160425105340.GE16065@arm.com>
 <alpine.DEB.2.10.1604251204380.24872@sstabellini-ThinkPad-X260>
 <20160425111938.GK16065@arm.com>
 <alpine.DEB.2.10.1604251221250.24872@sstabellini-ThinkPad-X260>
 <20160425125440.GN16065@arm.com>
Message-ID: <alpine.DEB.2.10.1604251356000.24872@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Apr 2016, Will Deacon wrote:
> On Mon, Apr 25, 2016 at 12:24:03PM +0100, Stefano Stabellini wrote:
> > On Mon, 25 Apr 2016, Will Deacon wrote:
> > > On Mon, Apr 25, 2016 at 12:04:53PM +0100, Stefano Stabellini wrote:
> > > > On Mon, 25 Apr 2016, Will Deacon wrote:
> > > > > On Mon, Apr 25, 2016 at 11:25:11AM +0100, Stefano Stabellini wrote:
> > > > > > From: Mark Rutland <mark.rutland@arm.com>
> > > > > > 
> > > > > > Improve the readability of dt_scan_depth1_nodes by removing the nested
> > > > > > conditionals.
> > > > > > 
> > > > > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > > > > Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> > > > > > 
> > > > > > ---
> > > > > > 
> > > > > > Note: this patch is based on xentip/for-linus-4.7
> > > > > 
> > > > > So how should I merge it? :/
> > > > 
> > > > I think that if you would like to merge it, it would be easier this time
> > > > for me to carry it in my tree. Otherwise you would have to base your
> > > > for-linus-4.7 on xentip/for-linus-4.7 and send the pull request after
> > > > the Xen pull request -- undesirable.
> > > 
> > > Ok, doesn't look like we'll run into conflicts. I just find it weird that
> > > you'd have a patch with no functional change as a dependency, hence my
> > > preference to queue it in the arm64 tree (where conflicts are more likely).
> >  
> > I see, that makes sense. In that case, would you be happy to take:
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/xen/tip.git/commit/?h=for-linus-4.7&id=df115bb0a0b8ad2f6dc62f8d094c21e77b367e7c
> > 
> > in your tree? That would get rid of any cross dependecies between the
> > two tree.
> 
> I can take that and the other patch on top too.

Perfect. I'll remove df115bb0a0b8ad2f6dc62f8d094c21e77b367e7c from xentip/for-linus-4.7.

Thanks,

Stefano

From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Apr 2013 10:25:45 +0900
Subject: [PATCH v2] ARM: shmobile: marzen-reference: use irqpin for lan
In-Reply-To: <20130410011201.GC11105@verge.net.au>
References: <1365556213-11827-1-git-send-email-horms+renesas@verge.net.au>
 <20130410011201.GC11105@verge.net.au>
Message-ID: <20130410012545.GD11105@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 10:12:01AM +0900, Simon Horman wrote:
> On Wed, Apr 10, 2013 at 10:10:13AM +0900, Simon Horman wrote:
> > This corrects the configuration of the SMSC lan controller
> > to use the newly added irqpin as its IRQ source.
> > 
> > Previously the lan controller did not work. Now it does.
> > 
> > Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Queued up in the marzen-boards branch.

Scratch that, I miss-tested things (again!) and this does not appear to work.

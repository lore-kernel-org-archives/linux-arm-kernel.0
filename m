From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 7 Nov 2013 12:54:08 -0500
Subject: [PATCH v4 05/31] mtd: nand: pxa3xx: devicetree binding update
In-Reply-To: <20131107164132.GA30917@localhost>
References: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383837455-30721-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131107153210.GK8308@titan.lakedaemon.net>
 <20131107164132.GA30917@localhost>
Message-ID: <20131107175408.GL8308@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 01:41:33PM -0300, Ezequiel Garcia wrote:
> On Thu, Nov 07, 2013 at 10:32:10AM -0500, Jason Cooper wrote:
> > On Thu, Nov 07, 2013 at 12:17:09PM -0300, Ezequiel Garcia wrote:
> > > Since the driver supports the new compatible string, the binding
> > > documentation must be updated to reflect it.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > Thanks for adding this, but please remember to update the Subject
> > string in the future.  Both this patch and the next one are changing the
> > Documentation/ portion of the tree, not drivers/.
> > 
> 
> Come again?
> 
> You mean "[PATCH] Documentation: mtd: nand: Do this"
> 
> In that case: sorry, I do it differently on purpose, it looks better
> to me (focus the affected driver), but maybe I'm wrong.

but it makes it more difficult for devicetree binding reviewers to find
the patch in the series.  Perhaps having 'binding' in the Subject is
sufficient.  We'll see how things unfold over the next few days.

thx,

Jason.

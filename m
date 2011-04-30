From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 30 Apr 2011 00:28:06 -0600
Subject: [PATCH v5 5/8] arm/dt: Drop irq_create_of_mapping() from arm code.
In-Reply-To: <alpine.LFD.2.00.1104292027560.24613@xanadu.home>
References: <20110429070135.12522.35745.stgit@ponder>
	<20110429071553.12522.65073.stgit@ponder>
	<alpine.LFD.2.00.1104292027560.24613@xanadu.home>
Message-ID: <20110430062806.GA3103@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 08:28:47PM -0400, Nicolas Pitre wrote:
> On Fri, 29 Apr 2011, Grant Likely wrote:
> 
> > It is now implemented by core code.
> > 
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >  arch/arm/kernel/devtree.c |   14 --------------
> >  1 files changed, 0 insertions(+), 14 deletions(-)
> 
> Maybe this should be folded in the patch that introduced this instead?

Yes, it should; but I've kept it separate for now because I don't have
an ack from benh to merge the core changes that do this yet.  When
that happens I'll squish the two patches together.

g.

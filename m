From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 15 Mar 2012 13:22:13 -0400
Subject: linux-next: build failure after merge of the final tree
 (arm-soc tree related)
In-Reply-To: <201203151639.38223.arnd@arndb.de>
References: <20120315105901.7b10c9f4de9374a613436988@canb.auug.org.au>
 <20120315002020.GA16189@titan.lakedaemon.net>
 <201203151639.38223.arnd@arndb.de>
Message-ID: <20120315172213.GC20243@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 04:39:38PM +0000, Arnd Bergmann wrote:
> On Thursday 15 March 2012, Jason Cooper wrote:
> > That's my mistake.  I did a pull request for the wrong branch.  Olof,
> > could you please drop the offending branch and I'll submit a new pull
> > request once I have a chance to test Arnd's irq patch?
> 
> I reverted this in the for-next branch for now. The two initial patches
> from the kirkwood/board branch are still present.

Okay, thanks.  I've rebased onto next/boards and merged the
depends/irqdomain branch.  I'm making progress, but not finished yet.

How is a pull-request done in the above scenario?  is my merge commit
included in the series?  what is the pull-request based on?
next/boards, or depends/irqdomain?

thx,

Jason.

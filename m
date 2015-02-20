From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 20 Feb 2015 17:17:49 +0100
Subject: [PATCH] genirq: fix virtual irq demuxer related comments
In-Reply-To: <20150220161259.GL13659@leverpostej>
References: <20150210150013.GD7119@twins.programming.kicks-ass.net>
 <1423582992-8154-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150210161425.GZ21418@twins.programming.kicks-ass.net>
 <20150220161259.GL13659@leverpostej>
Message-ID: <20150220161749.GR5029@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 04:12:59PM +0000, Mark Rutland wrote:
> Hi Peter,
> 
> On Tue, Feb 10, 2015 at 04:14:25PM +0000, Peter Zijlstra wrote:
> > On Tue, Feb 10, 2015 at 04:43:12PM +0100, Boris Brezillon wrote:
> > > Replace remaining 'Dumb' occurrences by 'Virtual'.
> > > Remove inappropriate notes in kerneldoc headers.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > 
> > Thanks, squished into the other one.
> 
> Would you be able to drop the virtual demuxer patch(es) for now?

Yeah, its commented out. With a comment saying I should track this
thread ;-)

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 May 2011 21:24:10 +0200
Subject: [PATCH v4 1/2] ARM: ELF: Define new core note type for VFP
	registers
In-Reply-To: <alpine.LFD.2.00.1105130926180.2762@xanadu.home>
References: <1302688597-2969-1-git-send-email-dave.martin@linaro.org>
	<20110513065902.GA2867@localhost>
	<alpine.LFD.2.00.1105130926180.2762@xanadu.home>
Message-ID: <201105132124.11176.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 May 2011, Nicolas Pitre wrote:
> On Fri, 13 May 2011, Dave Martin wrote:
> 
> > On Thu, May 12, 2011 at 10:14:00AM +0100, Russell King - ARM Linux wrote:
> > > On Tue, May 03, 2011 at 10:36:59AM +0100, Dave Martin wrote:
> > > > On Thu, Apr 28, 2011 at 07:49:25PM +0100, Russell King - ARM Linux wrote:
> > > > > On Wed, Apr 13, 2011 at 10:56:36AM +0100, Dave Martin wrote:
> > > > > > The VFP registers are not currently included in coredumps,
> > > > > > and there's no existing note type where they can sensibly be
> > > > > > included, so this patch defines a dedicated note type for them.
> > > > > 
> > > > > This probably wants to be copied to LKML (added).
> > > > 
> > > > Good point-- thanks.
> > > 
> > > What news on this?
> > 
> > None whatsoever.  Do you think I need to push harder for feedback?
> 
> I think that the patch should just be merged.  If someone had a problem 
> with this, we would have heard about it by now.
> 

Agreed. Uli and other toolchain people are waiting for this to get merged,
so we can put the ABI into gdb releases. It's definitely useful, and I couldn't
find anything wrong with it (but don't have much experience with ptrace).

	Arnd

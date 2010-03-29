From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 29 Mar 2010 09:55:03 -0700
Subject: [GIT PULL] generic arm for MSM try2
In-Reply-To: <alpine.LFD.2.00.1003281935450.694@xanadu.home>
References: <1269560155.21793.89.camel@c-dwalke-linux.qualcomm.com>
	<20100328214901.GA8614@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003281935450.694@xanadu.home>
Message-ID: <1269881703.17124.3.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-03-28 at 19:51 -0400, Nicolas Pitre wrote:
> On Sun, 28 Mar 2010, Russell King - ARM Linux wrote:
> 
> > On Thu, Mar 25, 2010 at 04:35:55PM -0700, Daniel Walker wrote:
> > > Ok, attempt #2 .. It's the same set of patches , only it's against
> > > mainline linus tree of the moment. I force updated it into the same
> > > "for-russell" branch.
> > > 
> > > btw, you might want to pay close attention to the "Fix incorrect
> > > permission faults" patch. That's the only non-small patch in the queue.
> > 
> > Well, I don't think it's fair on those who created abort-ev7.S to go
> > throwing a boilerplate copyright on the file which makes it look like
> > "Code Aurora Forum." wrote the entire thing.
> 
> When I brought up this point back in January or so, it was agreed that 
> such copyright notices were going to be removed.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-January/008824.html

I don't recall any hard agreements on it. Even reading the thread now,
it had to do with a minor change of only a few lines ..

Daniel

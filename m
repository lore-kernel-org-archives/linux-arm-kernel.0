From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 29 Mar 2010 15:18:08 -0400 (EDT)
Subject: [GIT PULL] generic arm for MSM try2
In-Reply-To: <1269889636.17124.30.camel@c-dwalke-linux.qualcomm.com>
References: <1269560155.21793.89.camel@c-dwalke-linux.qualcomm.com>
	<20100328214901.GA8614@n2100.arm.linux.org.uk>
	<1269881777.17124.5.camel@c-dwalke-linux.qualcomm.com>
	<20100329172841.GD28468@n2100.arm.linux.org.uk>
	<1269884644.17124.19.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1003291444130.694@xanadu.home>
	<1269889636.17124.30.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <alpine.LFD.2.00.1003291516250.694@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Mar 2010, Daniel Walker wrote:

> On Mon, 2010-03-29 at 14:51 -0400, Nicolas Pitre wrote:
> > On Mon, 29 Mar 2010, Daniel Walker wrote:
> > 
> > > On Mon, 2010-03-29 at 18:28 +0100, Russell King - ARM Linux wrote:
> > > > By putting such a boilerplate at the start of the file without some
> > > > acknowledgement of its past history, they are effectively saying that
> > > > their copyright extends to everything in the file.  That's certainly
> > > > not the case; take a moment to consider how you'd feel if someone threw
> > > > their copyright boilerplate on a file you'd written.
> > > 
> > > There is git history on it. Anyone that looks at the git history would
> > > know right off we didn't write the whole file. There's nothing stopping
> > > other copyright holders from adding their copyright on top of ours.
> > 
> > I think it is far more logical to view it the other way around: you 
> > don't need to add your own copyright notice for minor changes to every 
> > files you touch as the Git history already captures your contribution 
> > credits.
> 
> Git history captures who wrote the code, not who owns the code. I work
> for QuiC (Qualcomm Innovation Center) , however, the copyright is "Code
> Aurora Forum" .. The git history may list me as "@codeaurora.com" or
> "@quicinc.com" , so given that you really can't be sure of the copyright
> just with git history.

You may add any necessary clarifications in the commit log message.
The SOB tag is there for example.


Nicolas

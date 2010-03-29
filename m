From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 29 Mar 2010 11:20:34 -0700
Subject: [GIT PULL] generic arm for MSM try2
In-Reply-To: <20100329181717.GA15163@atrey.karlin.mff.cuni.cz>
References: <1269560155.21793.89.camel@c-dwalke-linux.qualcomm.com>
	<20100328214901.GA8614@n2100.arm.linux.org.uk>
	<1269881777.17124.5.camel@c-dwalke-linux.qualcomm.com>
	<20100329172841.GD28468@n2100.arm.linux.org.uk>
	<1269884644.17124.19.camel@c-dwalke-linux.qualcomm.com>
	<20100329181717.GA15163@atrey.karlin.mff.cuni.cz>
Message-ID: <1269886834.17124.24.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-03-29 at 20:17 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > 
> > > > > Well, I don't think it's fair on those who created abort-ev7.S to go
> > > > > throwing a boilerplate copyright on the file which makes it look like
> > > > > "Code Aurora Forum." wrote the entire thing.
> > > > 
> > > > You want the license and copyright removed? I can remove them, although
> > > > I rather not have too.
> > > 
> > > The fact of the matter is that "Code Aurora Forum" did not create this
> > > file, and their copyright does not cover the code which is already there.
> > 
> > Before we discuss it lets just be clear that I've already offered to
> > remove the copyright, and license changes.. I've not said that I
> > wouldn't do that , in fact I'll make a new pull request now minus those.
> > 
> > > By putting such a boilerplate at the start of the file without some
> > > acknowledgement of its past history, they are effectively saying that
> > > their copyright extends to everything in the file.  That's certainly
> > > not the case; take a moment to consider how you'd feel if someone threw
> > > their copyright boilerplate on a file you'd written.
> > 
> > There is git history on it. Anyone that looks at the git history would
> > know right off we didn't write the whole file. There's nothing stopping
> > other copyright holders from adding their copyright on top of ours.
> Maybe sane solution is to write "portions copyright"? people will not
>  dig into git history when there's just one author listed.


I tried that in the generic kernel once, and Andrew told me to remove
those parts because we had git history for that.. So I don't know, maybe
we need to require boiler plate copyrights on all files, and fix ones
that don't already have them.

Daniel

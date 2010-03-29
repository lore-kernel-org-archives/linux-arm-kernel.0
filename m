From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 29 Mar 2010 10:44:04 -0700
Subject: [GIT PULL] generic arm for MSM try2
In-Reply-To: <20100329172841.GD28468@n2100.arm.linux.org.uk>
References: <1269560155.21793.89.camel@c-dwalke-linux.qualcomm.com>
	<20100328214901.GA8614@n2100.arm.linux.org.uk>
	<1269881777.17124.5.camel@c-dwalke-linux.qualcomm.com>
	<20100329172841.GD28468@n2100.arm.linux.org.uk>
Message-ID: <1269884644.17124.19.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-03-29 at 18:28 +0100, Russell King - ARM Linux wrote:
> On Mon, Mar 29, 2010 at 09:56:17AM -0700, Daniel Walker wrote:
> > On Sun, 2010-03-28 at 22:49 +0100, Russell King - ARM Linux wrote:
> > > On Thu, Mar 25, 2010 at 04:35:55PM -0700, Daniel Walker wrote:
> > > > Ok, attempt #2 .. It's the same set of patches , only it's against
> > > > mainline linus tree of the moment. I force updated it into the same
> > > > "for-russell" branch.
> > > > 
> > > > btw, you might want to pay close attention to the "Fix incorrect
> > > > permission faults" patch. That's the only non-small patch in the queue.
> > > 
> > > Well, I don't think it's fair on those who created abort-ev7.S to go
> > > throwing a boilerplate copyright on the file which makes it look like
> > > "Code Aurora Forum." wrote the entire thing.
> > 
> > You want the license and copyright removed? I can remove them, although
> > I rather not have too.
> 
> The fact of the matter is that "Code Aurora Forum" did not create this
> file, and their copyright does not cover the code which is already there.

Before we discuss it lets just be clear that I've already offered to
remove the copyright, and license changes.. I've not said that I
wouldn't do that , in fact I'll make a new pull request now minus those.

> By putting such a boilerplate at the start of the file without some
> acknowledgement of its past history, they are effectively saying that
> their copyright extends to everything in the file.  That's certainly
> not the case; take a moment to consider how you'd feel if someone threw
> their copyright boilerplate on a file you'd written.

There is git history on it. Anyone that looks at the git history would
know right off we didn't write the whole file. There's nothing stopping
other copyright holders from adding their copyright on top of ours.


Daniel

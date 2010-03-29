From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Mar 2010 18:28:42 +0100
Subject: [GIT PULL] generic arm for MSM try2
In-Reply-To: <1269881777.17124.5.camel@c-dwalke-linux.qualcomm.com>
References: <1269560155.21793.89.camel@c-dwalke-linux.qualcomm.com>
	<20100328214901.GA8614@n2100.arm.linux.org.uk>
	<1269881777.17124.5.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100329172841.GD28468@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 29, 2010 at 09:56:17AM -0700, Daniel Walker wrote:
> On Sun, 2010-03-28 at 22:49 +0100, Russell King - ARM Linux wrote:
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
> You want the license and copyright removed? I can remove them, although
> I rather not have too.

The fact of the matter is that "Code Aurora Forum" did not create this
file, and their copyright does not cover the code which is already there.

By putting such a boilerplate at the start of the file without some
acknowledgement of its past history, they are effectively saying that
their copyright extends to everything in the file.  That's certainly
not the case; take a moment to consider how you'd feel if someone threw
their copyright boilerplate on a file you'd written.

Personally, I think this practice (adding copyright headers to pre-
existing files not authored by those claiming copyright ) is equivalent
to code theft.

It's far better to leave files without copyright headers if they start
out like that, or locate the original authors (Catalin) and have them
add a header.

Catalin, as the apparant author of this file, do you have a view on this?

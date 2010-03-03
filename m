From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 02 Mar 2010 16:39:20 -0800
Subject: board/device file names, and machine names
In-Reply-To: <20100302235137.GC29715@n2100.arm.linux.org.uk>
References: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
	<20100302235137.GC29715@n2100.arm.linux.org.uk>
Message-ID: <1267576760.8759.164.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-03-02 at 23:51 +0000, Russell King - ARM Linux wrote:
> On Tue, Mar 02, 2010 at 01:29:58PM -0800, Daniel Walker wrote:
> > So one device has at least three names (more I'm sure),
> > 
> > 	Passion
> > 	Mahimahi
> > 	Nexus One
> > 
> > Google has most of the code support under board files with the name
> > mahimahi.
> 
> I see no reason why the internal names can't be used in the code; just
> make the configuration option texts user-friendly so that the common
> names for the devices are used.

The internal names are usually available before the device also.
However, in the case above there are multiple internal names. I
personally think the naming matter, or making the tree more readable and
cleaner .. What do you think, does the file naming even matter?

> A comment at the top of the file may also help.
> 
> As far as filenames go, let's keep them the same for now; we can rename
> the filenames later once stuff is merged - while git can sort out
> subsequent _merges_ with files renamed, but what it can't do is apply
> patches on top of renamed files.  That's just something to be aware of
> when chosing when to rename.

I'm ok with doing renames once all the code is merged .. That's always
been one of the options with the Google code. 

However, we need some future direction .. If we do a rename later on
with the older code, then we ideally want new code to be submitted with
appropriate names..

Daniel

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Mar 2010 23:51:37 +0000
Subject: board/device file names, and machine names
In-Reply-To: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
References: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100302235137.GC29715@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 02, 2010 at 01:29:58PM -0800, Daniel Walker wrote:
> So one device has at least three names (more I'm sure),
> 
> 	Passion
> 	Mahimahi
> 	Nexus One
> 
> Google has most of the code support under board files with the name
> mahimahi.

I see no reason why the internal names can't be used in the code; just
make the configuration option texts user-friendly so that the common
names for the devices are used.

A comment at the top of the file may also help.

As far as filenames go, let's keep them the same for now; we can rename
the filenames later once stuff is merged - while git can sort out
subsequent _merges_ with files renamed, but what it can't do is apply
patches on top of renamed files.  That's just something to be aware of
when chosing when to rename.

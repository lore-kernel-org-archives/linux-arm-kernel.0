From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Feb 2012 16:14:57 +0000
Subject: Kirkwood, kernel 3.2, vmalloc region overlap, not starting up
In-Reply-To: <4F314D0C.50501@kernelconcepts.de>
References: <20120207152903.GA16238@lunn.ch> <4F314D0C.50501@kernelconcepts.de>
Message-ID: <20120207161457.GC889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2012 at 05:10:52PM +0100, Nils Faerber wrote:
> Apart from my joy - the basic reason for that change would be still
> interesting? Does this only apply to Kirwoods or my special board?

I don't think it's related to the uboot caching issues (but it could
be).

It needs someone to cook up a patch to find out what's going on, but
alas I don't have time at the moment, because I'm busy writing ARM
kautobuild V2 with kboottest functionality at the moment.

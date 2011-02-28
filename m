From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Feb 2011 15:11:00 +0000
Subject: When does mach-types get updated in a tree?
In-Reply-To: <0812376c-ea4b-4185-aa6e-6fb582dce21f@VA3EHSMHS032.ehs.local>
References: <a9937fcf-a4cb-41c5-a767-ecfebae5c748@VA3EHSMHS024.ehs.local>
	<20110228101030.GB29843@n2100.arm.linux.org.uk>
	<0812376c-ea4b-4185-aa6e-6fb582dce21f@VA3EHSMHS032.ehs.local>
Message-ID: <20110228151100.GB1937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28, 2011 at 07:35:57AM -0700, John Linn wrote:
> What is your suggestion to people with regards to patches that need the
> update?

The only suggestion I can make is: don't wait until the last minute before
putting something into the machine registry, because you will get into
these kinds of problems.

If I do an update now, it'll be the second time it's happened in February.
It's likely it will need another update just before the merge window too
in 3-4 weeks time.

So really all that I can say is that people need to ensure that they get
stuff from the machine registry earlier rather than later.

I do think we're heading for a major problem with the mach-types file
becoming too big inspite of its brevity.  I think I may start marking
entries as 'inactive' and therefore omitted from the kernel's tree if
they don't appear in mainline within one year of being allocated (or
some similar rule.)

> I'm open to suggestions, just trying to work with everyone the best way
> to get Xilinx patches into the system.

The only thing I can think is to wait a couple more weeks and I'll see
about doing an update mid-March.  Maybe by then we can have a smaller
file...

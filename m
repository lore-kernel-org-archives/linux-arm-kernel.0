From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Mar 2011 23:10:13 +0000
Subject: Updated mach-types update
In-Reply-To: <20110321234150.23936e8f.dv@vollmann.ch>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
	<20110321234150.23936e8f.dv@vollmann.ch>
Message-ID: <20110321231013.GH4340@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2011 at 11:41:50PM +0100, Detlef Vollmann wrote:
> On Sun, 20 Mar 2011 11:03:22 Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > What this means is that any platform in the machine database which has not
> > been submitted to mainline for 12 months since it was registered will be
> > automatically dropped from the file, and the platform maintainer will need
> > to either talk to me to get it reinstated before submission, or update the
> > entry in some way to 'freshen' it.
>
> So what happens to the number that was allocated for a platform that
> got dropped?  Will it be recycled for another platform or is it safe
> to use it in code that is not intended to go mainline (to avoid cluttering
> mainline with code that doesn't need to be mainline)?

You've completely misunderstood what I said.  Nothing has been deleted
from the database.  The file downloadable off the website continues to
give the full set of entries.

All that's happened is some filtering on the version I include in the
mainline kernel to make it saner.  There's no point including 2000
lines (which expand to about 700K of generated file) which aren't used
in the mainline kernel.

From: balbi@ti.com (Felipe Balbi)
Date: Thu, 20 Nov 2014 13:37:36 -0600
Subject: [PATCH 0/8] ARM cleanups
In-Reply-To: <20141117231626.GC9716@saruman>
References: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
 <20141117231626.GC9716@saruman>
Message-ID: <20141120193736.GB23217@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 05:16:26PM -0600, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Nov 17, 2014 at 08:29:11PM +0000, Russell King - ARM Linux wrote:
> > The following series is partly a result of reviewing differences
> > between ARM and ARM64, and cleans up ARM with some of the changes
> > made to ARM64.  Many of these changes are trivial cleanups.
> > 
> > I've also dropped some of the kernel boot messages - removing the
> > "SMP: Total of %d processors activated" message which was redundant,
> > and dropping a couple of others to debug level.
> > 
> > I've moved the ftrace assembly code to its own separate file, just
> > like on ARM64.
> > 
> > I've been running stuff with this for a number of weeks now, and
> > haven't noticed any regressions.
> 
> Have you got a branch with these in for convenience of testing ?
> Otherwise I'll just pick them all up and add to my TODO list for
> tomorrow, got a couple boards here to run these against.

Have been running these for a couple days on my boards and also didn't
nothing anything problematic. I quite like that we know print mach->desc
on stack trace.

Tested-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141120/8c34ad85/attachment.sig>

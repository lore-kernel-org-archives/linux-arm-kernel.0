From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 May 2010 14:08:40 +0100
Subject: RMK closing tree to patches *this* weekend
In-Reply-To: <alpine.LFD.2.00.1005170858290.12758@xanadu.home>
References: <20100513230201.GA26822@n2100.arm.linux.org.uk>
	<20100517090310.GE23118@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1005170858290.12758@xanadu.home>
Message-ID: <20100517130840.GD29422@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 09:04:53AM -0400, Nicolas Pitre wrote:
> On Mon, 17 May 2010, Russell King - ARM Linux wrote:
> 
> > Right, my tree is now frozen for new patches; I won't be taking any
> > more patches into the devel side from the patch system, and I won't
> > be pulling any further trees into my tree either.
> 
> For the record, I sent you an initial pull request on May 3rd, and a 
> ping on May 14th.

It got pulled on the 14th.

> I still don't see it in your tree.

As is my standard procedure, it's pulled into devel-stable and if you
look there, you'll see it.  devel-stable has been dropped from the main
devel branch while I wait for Hartley to produce his patch (which is
dependent on everything else in the devel branch.)

Once that's in, I'll be re-merging devel-stable back into devel, and
then applying a patch from John Schultz removing all the now redundant
'select GENERIC_TIME' statements.

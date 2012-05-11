From: horms@verge.net.au (Simon Horman)
Date: Fri, 11 May 2012 17:05:40 +0900
Subject: [PATCH] mach-shmobile: Emma Mobile EV2 SMP prototype code
In-Reply-To: <20120511071305.GD17741@verge.net.au>
References: <20120509075407.5991.60556.sendpatchset@w520>
 <20120511071305.GD17741@verge.net.au>
Message-ID: <20120511080534.GA8876@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 04:13:08PM +0900, Simon Horman wrote:
> On Wed, May 09, 2012 at 04:54:07PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Prototype code that adds SMP support to EMEV2.
> > 
> > At this point only the most basic form of SMP operation
> > is supported. TWD and CPU Hotplug support is excluded.
> > 
> > Based on V1 of the Emma Mobile EV2 code. Needs to be
> > reworked to coexist with DT. Work in progress.
> 
> Hi Magnus,
> 
> I tried out this patch on top of the next branch of Rafael's
> renesas tree (5658c94) plus V2 of your Emma Mobile EV2 code but
> I am only seeing one CPU.  Do I need some other tweaks?

Hi Magnus,

it turns out that I had maxcpus=1 set on the command line.
After removing that all seems well.

Tested-by: Simon Horman <horms@verge.net.au>

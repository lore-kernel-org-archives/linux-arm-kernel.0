From: horms@verge.net.au (Simon Horman)
Date: Mon, 1 Jul 2013 10:29:26 +0900
Subject: [PATCH] ARM: shmobile: Sort r8a7790 MSTP entries
In-Reply-To: <20130701011456.GA14567@verge.net.au>
References: <20130628101327.26876.89435.sendpatchset@w520>
 <20130701011456.GA14567@verge.net.au>
Message-ID: <20130701012925.GB14567@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 10:14:57AM +0900, Simon Horman wrote:
> On Fri, Jun 28, 2013 at 07:13:27PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > The r8a7790 MSTP bits should be kept sorted in the same way
> > as on other mach-shmobile SoCs. Move the HSCIF and thermal
> > bits to clean up the current state.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Thanks, I will queue this up in the cleanup branch.

I've added it to the soc branch instead as it is depended
on by other patches that seem to make sense there.

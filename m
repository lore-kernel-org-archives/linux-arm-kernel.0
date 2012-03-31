From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Sat, 31 Mar 2012 13:43:32 -0700
Subject: [PATCH RFC] Simplify the Linux kernel by reducing its state space
In-Reply-To: <4F77681E.5010608@xenotime.net>
References: <20120331163321.GA15809@linux.vnet.ibm.com>
 <20120331201500.GA27640@linas.org> <4F77681E.5010608@xenotime.net>
Message-ID: <20120331204332.GH2450@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2012 at 01:25:02PM -0700, Randy Dunlap wrote:
> On 03/31/2012 01:15 PM, Linas Vepstas wrote:
> 
> > 
> > Hi,
> > 
> > I didn't actually try to compile the patch below; it didn't look like
> > C code so I wasn't sure what compiler to run it through.  I guess maybe
> > its python?  However, I'm very sure that the patches are completely
> > correct, because I read them, and I also know Paul.  And I've heard of
> > Thomas Gleixner.
> 
> 
> x86_64 defconfig has many build errors and warnings.  :(

I suggest removing the code containing the errors and warnings.  I bet
that the offending code is not needed when running with zero CPUs.

> back to my abacus.

;-)

							Thanx, Paul

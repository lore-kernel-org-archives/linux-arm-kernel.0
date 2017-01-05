From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 5 Jan 2017 09:58:51 -0800
Subject: [PATCH] mtd: nand: lpc32xx: fix invalid error handling of a
 requested irq
In-Reply-To: <20170103114746.141d7d7d@bbrezillon>
References: <20161205014710.2015-1-vz@mleia.com>
 <20170103101259.0ec123df@bbrezillon>
 <72ab91ec-a919-af42-8a82-f5d99b245edf@mleia.com>
 <20170103114746.141d7d7d@bbrezillon>
Message-ID: <20170105175851.GC50438@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 11:47:46AM +0100, Boris Brezillon wrote:
> On Tue, 3 Jan 2017 12:16:26 +0200
> Vladimir Zapolskiy <vz@mleia.com> wrote:
> > On 01/03/2017 11:12 AM, Boris Brezillon wrote:
> > > Do you need to backport this fix to stable releases? If that's the
> > > case, I'll add the Cc: stable tag when applying.  
> > 
> > that will be great if you can add
> > 
> > Cc: stable at kernel.org # v4.7+
> > 
> > Please feel free to add also the tag
> > 
> > Fixes: 8cb17b5ed017 ("irqchip: Add LPC32xx interrupt controller driver")
> 
> Applied to nand/next (this patch will appear in 4.11).

For next time, checkpatch noticed that you got the stable address wrong:

ERROR:STABLE_ADDRESS: The 'stable' address should be 'stable at vger.kernel.org'
#17: Cc: stable at kernel.org # v4.7+

Brian

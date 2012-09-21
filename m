From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Sep 2012 14:52:50 +0000
Subject: [GIT PULL] ARM initial multi-platform support
In-Reply-To: <20120921134532.GO2450@S2101-09.ap.freescale.net>
References: <5053B05C.7070801@gmail.com>
 <20120921045814.GA30535@quad.lixom.net>
 <20120921134532.GO2450@S2101-09.ap.freescale.net>
Message-ID: <201209211452.51550.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 September 2012, Shawn Guo wrote:
> On Thu, Sep 20, 2012 at 09:58:14PM -0700, Olof Johansson wrote:
> > I pulled in this branch now. I created a new next/multiplatform branch that
> > contains this branch plus one more patch to sweep new dtb targets and move
> > them to the common file (will post that patch shortly).
> > 
> > To avoid the worst of the conflicts I ended up basing next/multiplatform on
> > next/cleanup + next/dt + next/soc.
> > 
> > Note that I have not yet merged in the smp_ops branch (will do final
> > sync-up with Arnd on that tomorrow), so selecting multiple targets will
> > fail building due to duplicate symbols.
> > 
> We need to merge arm-soc/multiplatform/platform-data as well?

Yes, that's right.

	Arnd

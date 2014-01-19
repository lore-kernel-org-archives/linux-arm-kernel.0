From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 18 Jan 2014 21:29:53 -0300
Subject: [PATCH] ARM: kirkwood: kirkwood_pm_init() should return void
In-Reply-To: <20140118235411.GN29184@titan.lakedaemon.net>
References: <1389984731-20220-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140118235411.GN29184@titan.lakedaemon.net>
Message-ID: <20140119002952.GA2412@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 18, 2014 at 06:54:11PM -0500, Jason Cooper wrote:
> On Fri, Jan 17, 2014 at 03:52:11PM -0300, Ezequiel Garcia wrote:
> > This function was originally meant to return void as declared in the
> > common.h header. Fix it and include the header to catch these errors
> > in the future.
> > 
> > Reported-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  arch/arm/mach-kirkwood/pm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> merf.  I get the following warning when building kirkwood_defconfig:
> 
> arch/arm/mach-kirkwood/pm.c: In function 'kirkwood_pm_init':
> arch/arm/mach-kirkwood/pm.c:73:2: warning: 'return' with a value, in function returning void [enabled by default]
> 

Doh...

> I've amended the patch as below and pushed it to mvebu/fixes
> 

Thanks!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

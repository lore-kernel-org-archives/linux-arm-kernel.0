From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 23 Sep 2013 09:32:48 -0400
Subject: [PATCH 15/26] ARM: kirkwood: remove custom .init_time hook
In-Reply-To: <20130921202753.GB735@lunn.ch>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-16-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130921202753.GB735@lunn.ch>
Message-ID: <20130923133248.GG11119@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 21, 2013 at 10:27:53PM +0200, Andrew Lunn wrote:
> On Wed, Sep 18, 2013 at 07:53:48PM +0200, Sebastian Hesselbarth wrote:
> > With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> > remove custom .init_time hooks.
> > 
> > Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > ---
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: linux-kernel at vger.kernel.org
> > ---
> >  arch/arm/mach-kirkwood/board-dt.c |    8 --------
> >  1 file changed, 8 deletions(-)
> 
> 
> Hi Sebastian
> 
> Boot tested on a Kirkwood Topkick.
> 
> Tested-by: Andrew Lunn <andrew@lunn.ch>

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

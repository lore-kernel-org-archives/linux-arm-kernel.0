From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 02 Dec 2011 16:39:31 -0500 (EST)
Subject: [PATCH 07/23] ARM: plat-omap: remove arch specific special
 handling for ioremap
In-Reply-To: <20111202202125.GZ31337@atomide.com>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
 <1321422521-1138-8-git-send-email-nico@fluxnic.net>
 <20111202202125.GZ31337@atomide.com>
Message-ID: <alpine.LFD.2.02.1112021637200.2357@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Dec 2011, Tony Lindgren wrote:

> Hi Nico,
> 
> * Nicolas Pitre <nico@fluxnic.net> [111115 21:21]:
> > From: Nicolas Pitre <nicolas.pitre@linaro.org>
> > 
> > A generic version should replace this later.
> > 
> > As io.c has become nearly empty, omap_init_consistent_dma_size() is moved
> > into common.c so that io.c can be removed entirely.
> 
> Sorry for the delay on trying this series out. It boots fine
> on omap2/3/4 as Kevin already noted. However, the following
> fix is needed for this patch to keep things building for
> omap1_defconfig.
>  
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> With the following fix it works on what I tested. That's
> osk5912 n800 2430sdp n900 zoom3 and blaze. If you're still
> taking acks for this series:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

OK, thanks for testing.  Since Russell didn't commit this to his stable 
branch yet I simply folded in your fix and added your tested-by tag.


Nicolas

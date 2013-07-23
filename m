From: olof@lixom.net (Olof Johansson)
Date: Mon, 22 Jul 2013 19:47:39 -0700
Subject: [PATCH] ARM: multi_v7: Enabled omap4430 sdp nfsroot
In-Reply-To: <20130715132326.GA12025@arwen.pp.htv.fi>
References: <20130715075816.GN7656@atomide.com>
 <20130715132326.GA12025@arwen.pp.htv.fi>
Message-ID: <20130723024739.GB15637@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 04:23:26PM +0300, Felipe Balbi wrote:
> On Mon, Jul 15, 2013 at 12:58:17AM -0700, Tony Lindgren wrote:
> > Author: Tony Lindgren <tony@atomide.com>
> > Date:   Mon Jul 15 00:39:41 2013 -0700
> > 
> >     ARM: multi_v7: Enabled omap4430 sdp nfsroot
> >     
> >     By adding support for OCP2SCP, SPI and KS8851 I can also boot test
> >     multi_v7_defconfig easily.
> >     
> >     Note that if using an older u-boot, CONFIG_ARM_ATAG_DTB_COMPAT=y
> >     may also be needed for the appended DTB based booting.
> >     
> >     Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> We will also use OCP2SCP driver to enable USB3 on OMAP5 uEVM, good it's
> already enabled in multi_v7 after this patch.
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Applied to fixes for 3.11 since it gives us networking on panda.


-Olof

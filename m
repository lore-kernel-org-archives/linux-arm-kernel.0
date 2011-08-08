From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 9 Aug 2011 05:59:15 +0800
Subject: [GIT PULL] imx-fixes
In-Reply-To: <20110808064157.GC17990@pengutronix.de>
References: <20110808063549.GL31404@pengutronix.de>
	<20110808064157.GC17990@pengutronix.de>
Message-ID: <20110808215914.GA2837@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Aug 08, 2011 at 08:41:57AM +0200, Sascha Hauer wrote:
> On Mon, Aug 08, 2011 at 08:35:49AM +0200, Sascha Hauer wrote:
> > 
> > Hi Arnd,
> > 
> > Please pull the following fixes for i.MX.
> 
> Added one patch from Arnaud Patard to this series:
> 
> commit d9c927833a42b4eaae4addd031f780f4530f7a2d
> Author: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
> Date:   Fri Aug 5 09:32:41 2011 +0200
> 
>     iMX: Fix build for iMX53
> 
I'm fine with the fact that you picked this over mine which I posted
below, as long as we fix the issue.  But it seems that I need to ping
you harder to pick my patch in the future, if somehow you will easily
forget/overlook my patches :)

http://article.gmane.org/gmane.linux.ports.arm.kernel/125945

commit 8065dff7367b6efd9859b223e06e57465a1d3cee
Author: Shawn Guo <shawn.guo@linaro.org>
Date:   Wed Jul 20 20:48:32 2011 +0800

    arm/mxc: add the missing UART_PADDR for i.mx53

    The UART_PADDR definition for i.mx53 and i.mx50 is missing in
    debug-macro.S.  It causes the build of i.mx53/50 fail.

    Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
    Reported-by: Troy Kisky <troy.kisky@boundarydevices.com>

-- 
Regards,
Shawn

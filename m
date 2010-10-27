From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 27 Oct 2010 11:09:21 +0200
Subject: [PATCH] ARM: imx: Add some core definitions for MX53
In-Reply-To: <20101027082958.GA6797@angua.secretlab.ca>
References: <1288119235-7036-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20101027082958.GA6797@angua.secretlab.ca>
Message-ID: <20101027090921.GB8554@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Oct 27, 2010 at 09:29:59AM +0100, Grant Likely wrote:
> > ---
> >  arch/arm/plat-mxc/include/mach/iomux-mx53.h |  301 +++++++++++++++++++
> >  arch/arm/plat-mxc/include/mach/mx53.h       |  433 +++++++++++++++++++++++++++
> 
> Hi Dinh.
> 
> In general, these definitions should not be added until they are
> actually needed by driver code.
ack.

> Also, from my understanding, the mx53 is very similar to the mx51.
> If I'm correct, then they should be sharing the same set of #defines.
Note, I asked for a seperate header file.  See
http://thread.gmane.org/gmane.linux.kernel/1051001/focus=1051352

> What is the diff between *mx51.h and *mx53.h?
Just from a quick look at least some base addresses are different.
(e.g. MX51_DEBUG_BASE_ADDRESS = 0x60000000, MX53_DEBUG_BASE_ADDRESS =
0x40000000; SPBA0, AIPS1 and AIPS2 differ, too)

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

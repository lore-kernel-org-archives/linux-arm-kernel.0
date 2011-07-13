From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 13 Jul 2011 11:56:29 +0200
Subject: [PATCH V2 07/10] ARM: mxs: add sgtl5000 i2c device
In-Reply-To: <20110713091314.GC1928@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310528167-25035-1-git-send-email-b29396@freescale.com>
	<20110713091314.GC1928@pengutronix.de>
Message-ID: <20110713095629.GE1928@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2011 at 11:13:14AM +0200, Wolfram Sang wrote:
> On Wed, Jul 13, 2011 at 11:36:07AM +0800, Dong Aisheng wrote:
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  arch/arm/mach-mxs/mach-mx28evk.c |   16 ++++++++++++++++
> >  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> Also needs in Kconfig:
> 
> +       select MXS_HAVE_PLATFORM_MXS_I2C

#include <linux/i2c.h> for i2c_register_board_info() might be good,
too...

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110713/b07d8514/attachment.sig>

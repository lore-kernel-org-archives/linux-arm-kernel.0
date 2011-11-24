From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 24 Nov 2011 08:49:38 +0100
Subject: [PATCH v7 0/3] ARM: mxs: add recording support for saif
In-Reply-To: <20111124074619.GJ17979@S2100-06.ap.freescale.net>
References: <a> <1321977265-14959-1-git-send-email-b29396@freescale.com>
 <20111124073605.GI17979@S2100-06.ap.freescale.net>
 <20111124074619.GJ17979@S2100-06.ap.freescale.net>
Message-ID: <20111124074938.GA8439@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 03:46:20PM +0800, Shawn Guo wrote:
> On Thu, Nov 24, 2011 at 03:36:05PM +0800, Shawn Guo wrote:
> > During the testing, the saif driver's dependency on
> > REGULATOR_FIXED_VOLTAGE was found.  I guess it should be resolved
> > in sound/soc/mxs/Kconfig rather than leaving it to users.
> > 
> Also SND_SOC_MXS_SGTL5000 should probably depends on I2C_MXS than I2C.

Please explain.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111124/be61508b/attachment.sig>

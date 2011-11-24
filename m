From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 24 Nov 2011 16:23:13 +0800
Subject: [PATCH v7 0/3] ARM: mxs: add recording support for saif
In-Reply-To: <20111124074938.GA8439@pengutronix.de>
References: <a> <1321977265-14959-1-git-send-email-b29396@freescale.com>
 <20111124073605.GI17979@S2100-06.ap.freescale.net>
 <20111124074619.GJ17979@S2100-06.ap.freescale.net>
 <20111124074938.GA8439@pengutronix.de>
Message-ID: <20111124082312.GA18060@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 08:49:38AM +0100, Wolfram Sang wrote:
> On Thu, Nov 24, 2011 at 03:46:20PM +0800, Shawn Guo wrote:
> > On Thu, Nov 24, 2011 at 03:36:05PM +0800, Shawn Guo wrote:
> > > During the testing, the saif driver's dependency on
> > > REGULATOR_FIXED_VOLTAGE was found.  I guess it should be resolved
> > > in sound/soc/mxs/Kconfig rather than leaving it to users.
> > > 
> > Also SND_SOC_MXS_SGTL5000 should probably depends on I2C_MXS than I2C.
> 
> Please explain.
> 
Sorry.  I meant 'select I2C_MXS'.

-- 
Regards,
Shawn

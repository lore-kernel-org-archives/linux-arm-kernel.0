From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Jun 2013 18:22:42 -0700
Subject: [PATCHv6 6/6] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
In-Reply-To: <1370995696.7804.17.camel@linux-builds1>
References: <1370444578-25721-1-git-send-email-dinguyen@altera.com>
 <1370444578-25721-7-git-send-email-dinguyen@altera.com>
 <20130611232756.GD23774@quad.lixom.net>
 <1370995696.7804.17.camel@linux-builds1>
Message-ID: <20130612012242.GL23774@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 07:08:16PM -0500, Dinh Nguyen wrote:
> Hi Olof,
> 
> On Tue, 2013-06-11 at 16:27 -0700, Olof Johansson wrote:
> > Hi,
> > 
> > On Wed, Jun 05, 2013 at 10:02:58AM -0500, dinguyen at altera.com wrote:
> > > From: Dinh Nguyen <dinguyen@altera.com>
> > > 
> > > Add platform specific functionality for the DW SD/MMC driver for
> > > SoCFPGA. Move SDMMC_CMD_USE_HOLD_REG to dw_mmc.h so other platforms
> > > can use this define.
> > > 
> > > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > > CC: Seungwon Jeon <tgih.jun@samsung.com>
> > > CC: Jaehoon Chung <jh80.chung@samsung.com>
> > > CC: Arnd Bergmann <arnd@arndb.de>
> > > CC: Olof Johansson <olof@lixom.net>
> > > CC: Pavel Machek <pavel@denx.de>
> > > CC: linux-mmc at vger.kernel.org
> > 
> > Acked-by: Olof Johansson <olof@lixom.net>
> > 
> > This one should be sent to (and applied by) Chris Ball, the MMC maintainer. The
> > driver is standalone and can go in independently on the platform code that will
> > configure it, so he can merge it without dependencies.
> 
> Thanks Olof. I will send to Chris Ball. I kinda thought that since
> Jaehoon and Seungwon were maintainers of the dw_mmc driver that I didn't
> need to send to Chris.

Ah, no, it should probably go up through his tree in this case. It's
still good to have their Acked-by though, since they know the details
of the DW side.


-Olof

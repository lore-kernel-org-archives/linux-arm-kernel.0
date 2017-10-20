From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Fri, 20 Oct 2017 13:56:36 +0200
Subject: [PATCH 1/1] tty: serial: imx: disable ageing timer interrupt if
 dma in use
In-Reply-To: <AM3P101MB01800FAA2029393C5A859629E64A0@AM3P101MB0180.NAMP101.PROD.OUTLOOK.COM>
References: <20171007014648.6989-1-troy.kisky@boundarydevices.com>
 <AM3P101MB01800FAA2029393C5A859629E64A0@AM3P101MB0180.NAMP101.PROD.OUTLOOK.COM>
Message-ID: <20171020115636.GB2073@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 06:22:53AM +0000, Han, Nandor (GE Healthcare) wrote:
> 
> 
> > -----Original Message-----
> > From: linux-serial-owner at vger.kernel.org [mailto:linux-serial-
> > owner at vger.kernel.org] On Behalf Of Troy Kisky
> > Sent: 07 October 2017 04:47
> > To: gregkh at linuxfoundation.org
> > Cc: fabio.estevam at nxp.com; l.stach at pengutronix.de; u.kleine-
> > koenig at pengutronix.de; linux-serial at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org; Troy Kisky <troy.kisky@boundarydevices.com>
> > Subject: EXT: [PATCH 1/1] tty: serial: imx: disable ageing timer interrupt if
> > dma in use
> > 
> > Since commit 4dec2f119e86 ("imx-serial: RX DMA startup latency")
> > 
> > the interrupt routine no longer will start rx dma.
> 
> I think you have 2 commits here: 
> - one that disables ageing timer when DMA is in use
> - one that cleans the leftovers after 4dec2f119e86.

I agree, Troy, please make a patch series here.

thanks,

greg k-h

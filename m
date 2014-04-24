From: marex@denx.de (Marek Vasut)
Date: Thu, 24 Apr 2014 15:45:42 +0200
Subject: [PATCH v1 1/7] mtd: spi-nor: fix the wrong dummy value
In-Reply-To: <20140424045027.GA29664@localhost>
References: <a> <201404232141.27005.marex@denx.de>
 <20140424045027.GA29664@localhost>
Message-ID: <201404241545.42877.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 24, 2014 at 06:50:29 AM, Huang Shijie wrote:
> On Wed, Apr 23, 2014 at 09:41:26PM +0200, Marek Vasut wrote:
> > On Wednesday, April 23, 2014 at 12:16:49 PM, Huang Shijie wrote:
> > > For the DDR Quad read, the dummy cycles maybe 3 or 6 which is less then
> > > 8. The dummy cycles is actually 8 for SPI fast/dual/quad read.
> > > 
> > > This patch makes preparations for the DDR quad read, it fixes the wrong
> > > dummy value for both the spi-nor.c and m25p80.c.
> > > 
> > > Signed-off-by: Huang Shijie <b32955@freescale.com>
> > 
> > This patch is actually V2, right ?
> 
> yes.
> 
> I mentioned it in the cover letter. Since other patches are the V1.
> I did not change it to v2.

So next one is V3 ;-)

Best regards,
Marek Vasut

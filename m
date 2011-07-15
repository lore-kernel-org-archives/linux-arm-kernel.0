From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 15 Jul 2011 12:42:54 +0800
Subject: [PATCH v2] mtd: dataflash: add device tree probe support
In-Reply-To: <20110714175013.GA17845@belfalas.ww600.siemens.net>
References: <1310283313-32087-1-git-send-email-shawn.guo@linaro.org>
	<1310658757-17018-1-git-send-email-shawn.guo@linaro.org>
	<20110714175013.GA17845@belfalas.ww600.siemens.net>
Message-ID: <20110715044253.GA1840@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 09:52:02PM +0400, Dmitry Eremin-Solenikov wrote:
> On Thu, Jul 14, 2011 at 11:52:37PM +0800, Shawn Guo wrote:
> > It adds device tree probe support for mtd_dataflash driver.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> > ---
> > Changes since v1:
> >  * Add "atmel,at45xxx" into the match table
> >  * Add binding document
> 
> I?m sorry for being unclean on this. Device family is just at45,
> so I?d suggest the following compatibility list:
> "atmel,at45d789000", "atmel,at45"
> 
Ok.

> You might want to add "atmel,dataflash" or "mtd,dataflash", but I see
> no point in that.
> 
The binding I'm adding is for atmel dataflash (following the driver
name).  I want the binding to be scalable to cover possible new
atmel dataflash family other than at45.  We do not want to change
binding every time one new family comes out, do we?

-- 
Regards,
Shawn

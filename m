From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 23 Jan 2013 13:50:01 +0100
Subject: [PATCH 1/2] misc/at24: Add at24c512b eeprom support
In-Reply-To: <CACRpkdbQcyO82Z7+v61VmJBOHuPVT2ZphQQT7OpZ9edYbho5YQ@mail.gmail.com>
References: <1358922764-31654-1-git-send-email-Ying.Liu@freescale.com>
 <CACRpkdbQcyO82Z7+v61VmJBOHuPVT2ZphQQT7OpZ9edYbho5YQ@mail.gmail.com>
Message-ID: <20130123125001.GG16264@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 01:24:52PM +0100, Linus Walleij wrote:
> On Wed, Jan 23, 2013 at 7:32 AM, Liu Ying <Ying.Liu@freescale.com> wrote:
> 
> > This patch adds at24c512b eeprom support.
> > The datasheet of at24c512b can be found at:
> > http://www.alldatasheet.com/datasheet-pdf/pdf/
> > 256958/ATMEL/AT24C512B-TH-B.html
> >
> > Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> 
> Arnd Bergmann is the misc maintainer, route this by him.

I usually take at24 patches via my I2C tree.

But not this one, though. The 512b can equally use the 512 entry. The
devicetree should contain both entries, the 512 one as a fallback. (And
the vendor is not "at24"!)

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130123/86f5b0b3/attachment.sig>

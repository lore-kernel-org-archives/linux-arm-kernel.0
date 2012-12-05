From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 05 Dec 2012 23:15:01 +0000
Subject: [PATCH RESEND] ARM/SPI: New driver for SPI master controller for
 CLPS711X-target
In-Reply-To: <20121205003331.9dd3d8f4eee2dfe84e7c08fa@mail.ru>
References: <1352309429-21482-1-git-send-email-shc_work@mail.ru>
 <201211122143.34537.arnd@arndb.de>
 <20121205003331.9dd3d8f4eee2dfe84e7c08fa@mail.ru>
Message-ID: <20121205231501.D40863E0E22@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Dec 2012 00:33:31 +0400, Alexander Shiyan <shc_work@mail.ru> wrote:
> On Mon, 12 Nov 2012 21:43:34 +0000
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Wednesday 07 November 2012, Alexander Shiyan wrote:
> > > This patch add new driver for CLPS711X SPI master controller.
> > > Due to platform limitations driver supports only 8 bit transfer mode.
> > > Chip select control is handled via GPIO.
> > > 
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> 
> Please apply this patch in the SPI tree.

Applied, thanks.

g.

> 
> -- 
> Alexander Shiyan <shc_work@mail.ru>

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

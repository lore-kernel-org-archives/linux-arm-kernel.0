From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 5 Dec 2012 00:33:31 +0400
Subject: [PATCH RESEND] ARM/SPI: New driver for SPI master controller
 for CLPS711X-target
In-Reply-To: <201211122143.34537.arnd@arndb.de>
References: <1352309429-21482-1-git-send-email-shc_work@mail.ru>
 <201211122143.34537.arnd@arndb.de>
Message-ID: <20121205003331.9dd3d8f4eee2dfe84e7c08fa@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Nov 2012 21:43:34 +0000
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 07 November 2012, Alexander Shiyan wrote:
> > This patch add new driver for CLPS711X SPI master controller.
> > Due to platform limitations driver supports only 8 bit transfer mode.
> > Chip select control is handled via GPIO.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 

Please apply this patch in the SPI tree.

-- 
Alexander Shiyan <shc_work@mail.ru>

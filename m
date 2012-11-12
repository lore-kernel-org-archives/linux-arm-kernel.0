From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 21:43:34 +0000
Subject: [PATCH RESEND] ARM/SPI: New driver for SPI master controller for
 CLPS711X-target
In-Reply-To: <1352309429-21482-1-git-send-email-shc_work@mail.ru>
References: <1352309429-21482-1-git-send-email-shc_work@mail.ru>
Message-ID: <201211122143.34537.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 November 2012, Alexander Shiyan wrote:
> This patch add new driver for CLPS711X SPI master controller.
> Due to platform limitations driver supports only 8 bit transfer mode.
> Chip select control is handled via GPIO.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Acked-by: Arnd Bergmann <arnd@arndb.de>

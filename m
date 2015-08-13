From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 12 Aug 2015 19:48:40 -0700
Subject: [PATCH v4 1/2] mtd: spi-nor: add driver for NXP SPI Flash
 Interface (SPIFI)
In-Reply-To: <1436473147-31063-2-git-send-email-manabian@gmail.com>
References: <1436473147-31063-1-git-send-email-manabian@gmail.com>
 <1436473147-31063-2-git-send-email-manabian@gmail.com>
Message-ID: <20150813024840.GE108786@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 10:19:06PM +0200, Joachim Eastwood wrote:
> Add SPI-NOR driver for the SPI Flash Interface (SPIFI)
> controller that is found newer NXP MCU devices.
> 
> The controller supports serial SPI Flash devices with 1-, 2-
> and 4-bit width in either SPI mode 0 or 3. The controller
> can operate in either command or memory mode. In memory mode
> the Flash is exposed as normal memory and can be directly
> accessed by the CPU.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Yep, same comments apply from v3. Sorry for the mixup.

Brian

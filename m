From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 17 Apr 2018 19:42:26 +0530
Subject: [RESEND PATCH v2 4/4] ARM: davinci: use aemif platform driver in
 legacy mode for da850-evm
In-Reply-To: <20180417102917.7794-5-brgl@bgdev.pl>
References: <20180417102917.7794-1-brgl@bgdev.pl>
 <20180417102917.7794-5-brgl@bgdev.pl>
Message-ID: <7055b7b9-2a55-73e7-0d82-6d291556accd@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2018 03:59 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We now support board files in aemif. Use the platform driver instead
> of the handcrafted API in da850-evm.
> 
> Note: the id of davinci_nand is changed to 0 in order to make it work
> with the new common-clock framework based psc driver.

Is this now needed after applying my patch dropping clock acquisition
from DaVinci NAND driver?

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Thanks,
Sekhar

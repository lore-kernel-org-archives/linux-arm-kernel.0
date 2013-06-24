From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Jun 2013 18:15:57 +0200
Subject: [PATCH] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <CAMj5Bkg_4G9n9BaQjA-Xj2p8jGO8PZxNW7E7jOeWMMZa5sH6yQ@mail.gmail.com>
References: <1371444872-26994-1-git-send-email-zhangfei.gao@linaro.org>
 <201306211341.53928.arnd@arndb.de>
 <CAMj5Bkg_4G9n9BaQjA-Xj2p8jGO8PZxNW7E7jOeWMMZa5sH6yQ@mail.gmail.com>
Message-ID: <10541174.SUr9yD0veu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 June 2013 16:49:08 zhangfei gao wrote:
> 
> Dear Arnd & Vinod
> 
> The suggestion of using dma_get_slave_channel instead of filter works here.
> Dma driver should modify accordingly.

The changes all look good to me, thanks a lot for following up!

However, you should really follow the procedure for posting patches even
if it's just for the sake of discussion:

* always provide a signed-off-by and a patch description
* use an email client that doesn't break whitespace
* I would have split this up into two separate patches, one for the
  subsystem and one for the new driver.

	Arnd

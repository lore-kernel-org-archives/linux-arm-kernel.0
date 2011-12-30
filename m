From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 30 Dec 2011 02:02:56 +0000
Subject: [PATCH] ARM: S3C64XX: Fix build of Cragganmore after SPI changes
In-Reply-To: <02cb01ccc696$c0088680$40199380$%kim@samsung.com>
References: <1325073936-10936-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <02cb01ccc696$c0088680$40199380$%kim@samsung.com>
Message-ID: <20111230020256.GD9737@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2011 at 11:00:05AM +0900, Kukjin Kim wrote:

> I couldn't look at the line of 's3c64xx_spi_set_info(...);' which is deleted
> in this patch in my tree. So I couldn't apply this.

> Do you want to apply this just to add 's3c64xx_spi0_set_platdata()'?

No, I think this is a case of me noticing a problem in a patch I thought
was already upstream (and pushed later in the day).  Sorry for the
noise.

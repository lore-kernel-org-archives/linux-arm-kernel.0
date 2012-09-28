From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 28 Sep 2012 14:04:36 +0100
Subject: [PATCH v2] spi/imx: set the inactive state of the clock
 according to the clock polarity
In-Reply-To: <1348572117-24607-1-git-send-email-dirk.behme@de.bosch.com>
References: <1348572117-24607-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20120928130436.GH30869@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 01:21:57PM +0200, Dirk Behme wrote:
> From: Knut Wohlrab <knut.wohlrab@de.bosch.com>
> 
> There are SPI devices which need a SPI clock with active low polarity and
> high inactive state.

Applied, thanks.

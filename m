From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Mon, 24 Sep 2012 08:34:27 +0200
Subject: [PATCH] spi/imx: set the inactive state of the clock according
 to the clock polarity
In-Reply-To: <20120924050655.GA27291@S2101-09.ap.freescale.net>
References: <1346403311-25080-1-git-send-email-dirk.behme@de.bosch.com>
 <20120924050655.GA27291@S2101-09.ap.freescale.net>
Message-ID: <505FFEF3.3000605@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 24.09.2012 07:06, Shawn Guo wrote:
> On Fri, Aug 31, 2012 at 10:55:11AM +0200, Dirk Behme wrote:
>> From: Knut Wohlrab <knut.wohlrab@de.bosch.com>
>>
>> There are SPI devices which need a SPI clock with active low polarity and
>> high inactive state.
>>
>> Add the setting of the inactive state ECSPIx_CONFIGREG:SCLK CTL
>> according to the clock polarity ECSPIx_CONFIGREG:SCLK POL:
>>
>> DT without "spi-cpol" = 0 = clock active high polarity = inactive state low
>> DT with    "spi-cpol" = 1 = clock active low  polarity = inactive state high
>>
>> Signed-off-by: Knut Wohlrab <knut.wohlrab@de.bosch.com>

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Being not so familiar with the flow of SPI patches, I was told that you 
are taking care of spi patches recently?

Do you like to have a look to this patch?

Many thanks and best regards

Dirk

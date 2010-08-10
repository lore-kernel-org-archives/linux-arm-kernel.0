From: B04825@freescale.com (Tabi Timur-B04825)
Date: Tue, 10 Aug 2010 10:08:46 -0400
Subject: [PATCH 4/8] ARM i.MX: add SDMA driver
In-Reply-To: <19553.23611.216618.916355@ipc1.ka-ro>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
	<1281344743-2029-5-git-send-email-s.hauer@pengutronix.de>
	<m2k4ny3jtn.fsf@ohwell.denx.de>
	<AANLkTikKFg62x_=BSZ29OaGz9=abk6PWN_u-+BvjB6Kw@mail.gmail.com>
	<19553.23611.216618.916355@ipc1.ka-ro>
Message-ID: <E6829185-A81A-4A1D-91AF-6792E44554AE@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org





On Aug 10, 2010, at 10:04 AM, Lothar Wa?mann <LW@KARO-electronics.de> wrote:

> Hi,
> 
> Timur Tabi writes:
>> On Tuesday, August 10, 2010, Detlev Zundel <dzu@denx.de>
>>> Apart from this I would also welcome if the whole driver could be
>>> adapted to the drivers/dma dmaengine API as pointed out by Linus
>>> Walleij.  The dma controller support for the Power Architecture chips of
>>> Freescale do implement this API, so this would also be a great step
>>> towards code unification of drivers here.
>> 
>> The Freescale PowerPC and ARM DMA controllers are completely
>> different, so I don't see how the drivers could be unified.
>> 
> The DMA API should abstract away the differences in the hardware
> so that device drivers could use DMA without having to know on what
> hardware they are running.

I thought you were talking about unifying the PowerPC DMA driver with the I.MX SDMA driver.

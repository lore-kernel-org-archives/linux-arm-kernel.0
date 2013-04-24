From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 24 Apr 2013 11:27:44 +0200
Subject: [PATCH v8 3/8] spi/spi-atmel: add dmaengine support
In-Reply-To: <20130423183301.GX5019@opensource.wolfsonmicro.com>
References: <1364968581-23700-1-git-send-email-wenyou.yang@atmel.com>
 <1364968759-24036-1-git-send-email-wenyou.yang@atmel.com>
 <20130403102332.GA4633@lnx-rg>
 <20130423183301.GX5019@opensource.wolfsonmicro.com>
Message-ID: <CACQ1gAh8QyZReJF2nQLQYSrYLv0vCw_ZS5rLg+S39LbbMJQyxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/4/23 Mark Brown <broonie@kernel.org>:
> On Wed, Apr 03, 2013 at 12:23:35PM +0200, Richard GENOUD wrote:
>
> Richard, delete irrelevant context from your mails - it makes it much
> easier to find the content you added.
>
>> On [mer., 03.04.2013 13:59:19], Wenyou Yang wrote:
>
>> As I did some work on that one:
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>>
>> BUT, there's one thing not working (at least for me !):
>> With DMA enabled, using spidev.
>> if we use the ioctl SPI_IOC_MESSAGE(x) (tested with x=3):
>
> I'd been expecting an updated series with this rolled in?

I did some more test with spidev and a MISO-MOSI loop as Wenyou suggested.

It's ok for me, on kernel 3.9-rc8 sam9g35, I didn't see any error.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Tested-by: Richard Genoud <richard.genoud@gmail.com>

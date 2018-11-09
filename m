From: florian.kauer@koalo.de (Florian Kauer)
Date: Fri, 9 Nov 2018 19:48:02 +0100
Subject: [PATCH 0/3] Fix MODULE_LICENSE of bcm2835 drivers
In-Reply-To: <815844594.141792.1541616607053@email.ionos.de>
References: <1540292769-5905-1-git-send-email-stefan.wahren@i2se.com>
 <815844594.141792.1541616607053@email.ionos.de>
Message-ID: <26a93a5d-0ed2-b82d-3a0b-ef2888c59af0@koalo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for not replying in time. I became father recently ;-)
So if it is still relevant:
Acked-by: Florian Kauer <florian.kauer@koalo.de>

On 07.11.2018 19:50, Stefan Wahren wrote:
> Hi Mark,
> hi Vinod,
> 
>> Stefan Wahren <stefan.wahren@i2se.com> hat am 23. Oktober 2018 um 13:06 geschrieben:
>>
>>
>> In preparation of a treewide switch of all bcm2835 drivers to SPDX tags,
>> we need to make sure that the license text and MODULE_LICENSE matches.
>>
>> This series starts sooner than usual to have more time to collect the authors
>> ACK.
>>
>> Stefan Wahren (3):
>>    clk: bcm2835: make license text and module license match
>>    dma: bcm2835: make license text and module license match
>>    spi: bcm2835: make license text and module license match
>>
>>   drivers/clk/bcm/clk-bcm2835-aux.c | 2 +-
>>   drivers/clk/bcm/clk-bcm2835.c     | 2 +-
>>   drivers/dma/bcm2835-dma.c         | 2 +-
>>   drivers/spi/spi-bcm2835.c         | 2 +-
>>   drivers/spi/spi-bcm2835aux.c      | 2 +-
>>   5 files changed, 5 insertions(+), 5 deletions(-)
>>
> 
> since i didn't receive any objections from the authors, could you please apply or should i resend with Eric's Reviewed-by?
> 

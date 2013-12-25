From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 25 Dec 2013 22:48:29 +0800
Subject: [PATCH] MAINTAINERS: ARM: SiRF: add sirf UART and watchdog to
 maintain list
In-Reply-To: <20131224083107.GB10158@pengutronix.de>
References: <1387807431-3547-1-git-send-email-21cnbao@gmail.com>
 <20131224083107.GB10158@pengutronix.de>
Message-ID: <CAGsJ_4xHWjYF2qC2sKg4kT+RO+u53W3LRQQRb03=ieuix1Qdkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/12/24 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Mon, Dec 23, 2013 at 10:03:51PM +0800, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> take CSR serial and watchdog drivers into maintain list.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  MAINTAINERS |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d5e4ff3..b9a1173 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -858,6 +858,8 @@ F:        drivers/mmc/host/sdhci-sirf.c
>>  F:   drivers/pinctrl/sirf/
>>  F:   drivers/rtc/rtc-sirfsoc.c
>>  F:   drivers/spi/spi-sirf.c
>> +F:   drivers/tty/serial/sirfsoc_uart.*
>> +F:   drivers/watchdog/sirfsoc_wdt.c
> Maybe just use
>
> N: sirf
>

Uwe, good idea.

> and AFAIK you should Cc: affected maintainers and optimally get their
> ack.
>
> Best regards and Merry Christmas

Merry Christmas and happy new year.

> Uwe

-barry

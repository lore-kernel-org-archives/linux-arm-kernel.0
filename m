From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 19 Jun 2016 22:44:20 +0900
Subject: [PATCH] clk: samsung: exynos5433: use clock_ignore_unused flag
 for SPI3 related clocks
In-Reply-To: <20160619055921.GA424@jack.zhora.eu>
References: <1466151362-2881-1-git-send-email-andi.shyti@samsung.com>
 <CA+Ln22F9eskcpnFkrnVFc3dJqCJcJ5O-STfXC-8Om5MK-THwNg@mail.gmail.com>
 <20160619055921.GA424@jack.zhora.eu>
Message-ID: <CA+Ln22HHNnPuEq1WVs+iiEEbAhdvkADhVkj99pqgR0qJODFUXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-06-19 14:59 GMT+09:00 Andi Shyti <andi@etezian.org>:
> Hi Tomasz,
>
>> > The SPI 3 bus uses two clocks, a bus clock and an input clock.
>> > Do not disable the clocks when unused in order to allow access to
>> > the SPI 3 device.
>>
>> If unused, why would access to SPI 3 device needed?
>
> because next I will submit a small driver which uses the SPI3.
> Actually in the exynos5433 boards all the SPI are used but not all
> the drivers are ported to mainline.

Then shouldn't the driver request the clocks and enable them? Or I'm
missing something obvious? :)

Best regards,
Tomasz

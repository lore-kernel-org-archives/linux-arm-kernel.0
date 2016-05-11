From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 11 May 2016 11:52:32 +0900
Subject: [RFC PATCH 13/21] reset: uniphier: add reset driver for UniPhier
 PH1-LD4 SoC
In-Reply-To: <1462883138.9155.3.camel@pengutronix.de>
References: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
 <1462873862-30940-14-git-send-email-yamada.masahiro@socionext.com>
 <1462883138.9155.3.camel@pengutronix.de>
Message-ID: <CAK7LNASY=Kg-KOMue09_YRoxrBAnXP00oqG4AC2iQM1HJgLc7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,


2016-05-10 21:25 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Hi Masahiro,
>
> Am Dienstag, den 10.05.2016, 18:50 +0900 schrieb Masahiro Yamada:
>> This series is just for review.
>> Please do not apply this patch.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> No need for all these tiny drivers. If you probe from DT as Lee
> requests, you can let of_device_id.data point to a compatible specific
> uniphier_reset_data.
>

I will need to fill the table a bit more to complete this work,
but I do not think this reset driver will become as big as the clk driver.
(I guess it will be less than 1000 lines.)

If you prefer a single file for the whole of this SoC family,
I can squash all the files into one.
(I can split it if I need to do so in the future.)



-- 
Best Regards
Masahiro Yamada

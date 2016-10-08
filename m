From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 8 Oct 2016 11:18:53 +0900
Subject: [PATCH] ARM: uniphier: select ARCH_HAS_RESET_CONTROLLER
In-Reply-To: <1474356649.4030.8.camel@pengutronix.de>
References: <1474346599-29925-1-git-send-email-yamada.masahiro@socionext.com>
 <1474356649.4030.8.camel@pengutronix.de>
Message-ID: <CAK7LNAQoOrvVLLyUdqmfzNo=+S4HRLfznq5RnaTC0KiKC2cJzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-09-20 16:30 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Am Dienstag, den 20.09.2016, 13:43 +0900 schrieb Masahiro Yamada:
>> The UniPhier reset driver (drivers/reset/reset-uniphier.c) has been
>> merged.  Select ARCH_HAS_RESET_CONTROLLER from the SoC Kconfig.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> regards
> Philipp


Applied.



-- 
Best Regards
Masahiro Yamada

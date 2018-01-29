From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Mon, 29 Jan 2018 15:11:51 +0100
Subject: [PATCH v2] irqchip: stm32: Fix copyright
In-Reply-To: <CALszF6Dfj5VzjU8gqbnGjLT3aty_OrXkFjP_8Jtp7mieXz4h=Q@mail.gmail.com>
References: <20171130084500.23439-1-benjamin.gaignard@st.com>
 <CALszF6Dfj5VzjU8gqbnGjLT3aty_OrXkFjP_8Jtp7mieXz4h=Q@mail.gmail.com>
Message-ID: <CA+M3ks6Hc34NDfdkJPNFqJd-0Q+1KPn-G5DFa+bpd8LyukQsdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-11-30 10:15 GMT+01:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:
> 2017-11-30 9:45 GMT+01:00 Benjamin Gaignard <benjamin.gaignard@linaro.org>:
>> Uniformize STMicroelectronics copyrights header
>> Add SPDX identifier
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
>> CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>  drivers/irqchip/irq-stm32-exti.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
>> index 31ab0dee2ce7..36f0fbe36c35 100644
>> --- a/drivers/irqchip/irq-stm32-exti.c
>> +++ b/drivers/irqchip/irq-stm32-exti.c
>> @@ -1,7 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0
>>  /*
>>   * Copyright (C) Maxime Coquelin 2015
>> + * Copyright (C) STMicroelectronics 2017
>>   * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> - * License terms:  GNU General Public License (GPL), version 2
>>   */
>>
>>  #include <linux/bitops.h>
>> --
>> 2.15.0
>>
>
> Acked-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>

Gentle ping on this simple SPDX patch.

Regards,
Benjamin

> Maxime

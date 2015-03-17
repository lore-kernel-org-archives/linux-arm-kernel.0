From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 17 Mar 2015 18:39:33 +0100
Subject: [PATCH v3 10/15] serial: stm32-usart: Add STM32 USART Driver
In-Reply-To: <1426239683.5304.59.camel@x220>
References: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>
 <1426197361-19290-11-git-send-email-maxime.coquelin@st.com>
 <1426239683.5304.59.camel@x220>
Message-ID: <CALszF6BdgwDQgK_mefCJm9zaDGAfhjh1GYCtJp4awgVb0Es4fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-13 10:41 GMT+01:00 Paul Bolle <pebolle@tiscali.nl>:
> Just a license nit, I'm afraid.
Not a problem, it is not the last round anyway.

>
> On Thu, 2015-03-12 at 22:55 +0100, Maxime Coquelin wrote:
>> --- /dev/null
>> +++ b/drivers/tty/serial/stm32-usart.c
>> @@ -0,0 +1,695 @@
>> +/*
>> + * Copyright (C) Maxime Coquelin 2015
>> + * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> + * License terms:  GNU General Public License (GPL), version 2
>> + *
>> + * Inspired by st-asc.c from STMicroelectronics (c)
>> + */
>
> This states the license is GPL v2.
>
>> +MODULE_LICENSE("GPL");
>
> And
>     MODULE_LICENSE("GPL v2");
>
> would match that statement.

Right, it will be fixed in the v4.

Thanks,
Maxime
>
>
> Paul Bolle
>

From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 17 Mar 2015 18:23:41 +0100
Subject: [PATCH v3 06/15] drivers: reset: Add STM32 reset driver
In-Reply-To: <1426236895.3083.20.camel@pengutronix.de>
References: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>
 <1426197361-19290-7-git-send-email-maxime.coquelin@st.com>
 <1426236895.3083.20.camel@pengutronix.de>
Message-ID: <CALszF6AS551JCxcfaKtPyeisbNt6OkdacS7uWaSEAEm3pRP95Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-13 9:54 GMT+01:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Am Donnerstag, den 12.03.2015, 22:55 +0100 schrieb Maxime Coquelin:
>> From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>
>> The STM32 MCUs family IP can be reset by accessing some shared registers.
>>
>> The specificity is that some reset lines are used by the timers.
>> At timer initialization time, the timer has to be reset, that's why
>> we cannot use a regular driver.
>
> But this is a regular driver now, should this comment be updated?
>

Indeed, I changed in v4 to:
    The STM32 MCUs family IPs can be reset by accessing some registers
    from the RCC block.

    The list of available reset lines is documented in the DT bindings.

Thanks,
Maxime
>
> regards
> Philipp
>

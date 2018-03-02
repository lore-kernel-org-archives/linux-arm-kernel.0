From: radoslaw.pietrzyk@gmail.com (=?UTF-8?Q?Rados=C5=82aw_Pietrzyk?=)
Date: Fri, 2 Mar 2018 09:37:21 +0100
Subject: [PATCH 2/2] ARM: pinctrl: stm32: Optimizes and enhances stm32gpio
 irqchip
In-Reply-To: <3526aa4e-a7cb-4108-5449-d77ae5e355ba@st.com>
References: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
 <1519221027-4028-3-git-send-email-radoslaw.pietrzyk@gmail.com>
 <CACRpkdbmmx7y3xJOOy0Dx62tMonkCgZeVzKYzr1B362QZe0fsA@mail.gmail.com>
 <CAFvLkMRRWZKqChFu+7yEDURtM_ZmmB1RMjj8yUwTZndiwySckA@mail.gmail.com>
 <3526aa4e-a7cb-4108-5449-d77ae5e355ba@st.com>
Message-ID: <CAFvLkMTN1NrdrT9aQjVmDtUNkwXbB0hEaPzE8Es1Axsch=BYzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus responded in v2 mail thread that he's gonna take it instead of v1.

2018-03-02 9:14 GMT+01:00 Alexandre Torgue <alexandre.torgue@st.com>:
> Hi Radoslaw and Linus,
>
>
> On 03/01/2018 10:24 PM, Rados?aw Pietrzyk wrote:
>>
>> I don't know if Alexandre agrees but It might be better to take v2
>> where irq_ack is added.
>
>
>
> Sorry Linus, I agree with Rodoslaw, you need to take V2 as stm32-exti patch
> is linked to pinctrl v2 patch. I gonna add my acked-by.
>
> Regards
> Alex
>
>
>>
>> 2018-03-01 22:04 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
>>>
>>> On Wed, Feb 21, 2018 at 2:50 PM, Radoslaw Pietrzyk
>>> <radoslaw.pietrzyk@gmail.com> wrote:
>>>
>>>>          - removes unneeded irq_chip.irq_eoi callback
>>>>          - adds irq_chip.irq_set_wake callback for possible
>>>>          in the future GPIO wakeup
>>>>
>>>> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
>>>
>>>
>>> Patch applied with Alexandre's ACK, stripping ARM from the
>>> commit message, thanks!
>>>
>>> Yours,
>>> Linus Walleij

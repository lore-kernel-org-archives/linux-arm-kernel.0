From: a0393675@ti.com (Keerthy)
Date: Wed, 29 Jun 2016 15:02:50 +0530
Subject: [PATCH v6 4/6] gpio: tps65218-gpio: Add platform_device_id table
In-Reply-To: <CACRpkdb=jz-=K-itevZtvPtHF05pKdhkSp1USaf5LzQWaxckJw@mail.gmail.com>
References: <1467117054-12943-1-git-send-email-j-keerthy@ti.com>
 <1467117054-12943-5-git-send-email-j-keerthy@ti.com>
 <CACRpkdb=jz-=K-itevZtvPtHF05pKdhkSp1USaf5LzQWaxckJw@mail.gmail.com>
Message-ID: <577395C2.5050807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 29 June 2016 02:26 PM, Linus Walleij wrote:
> On Tue, Jun 28, 2016 at 2:30 PM, Keerthy <j-keerthy@ti.com> wrote:
>
>> platform_device_id table is needed for adding the tps65218-gpio
>> module to the mfd_cell array.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> Changes in v4:
>>
>>    * Retained the compatible strings in order to interrogate the DT in the
>>      normal way.
>
> So do I just apply this or do you need it applied through another tree?
>
> It looks standalone, should I just merge it?
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Linus. I guess this can be merged by you. Is that fine Lee Jones?


>
> Yours,
> Linus Walleij
>

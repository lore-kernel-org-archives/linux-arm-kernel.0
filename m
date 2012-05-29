From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 29 May 2012 12:50:32 +0800
Subject: [PATCH 15/16] ARM: ux500: Add regulator support for nomadik-i2c
 into the db8500 Device Tree
In-Reply-To: <CACRpkdb80+4i_9JJpSu9X3biFywnFPvU-7HkZ94btz0iPL723A@mail.gmail.com>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-16-git-send-email-lee.jones@linaro.org>
 <CACRpkdanT17H4VV1AzaYN0wnsFKJTVhw0ZT+o3nP9v=gpKdyAQ@mail.gmail.com>
 <4FBB4782.9090101@linaro.org>
 <CACRpkdb80+4i_9JJpSu9X3biFywnFPvU-7HkZ94btz0iPL723A@mail.gmail.com>
Message-ID: <4FC45598.903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/05/12 09:53, Linus Walleij wrote:
> On Tue, May 22, 2012 at 4:00 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> This doesn't change the behavior of the current system, only DT:s it.
>>
>> It's just that:
>>
>>> struct regulator_consumer_supply db8500_vape_consumers[] = {
>>>         REGULATOR_SUPPLY("v-i2c", "nmk-i2c.0")
>>
>> In drivers/mfd/db8500-prcmu.c is replaced by:
>>
>>> v-i2c-supply =<&db8500_vape_reg>;
>>
>> In the Device Tree
>
> Yes...
>
>> If we want to start re-working things, can we do it after the DT enablement
>> please?
>
> I'm told not to put DT bindings for things in place if they are
> incorrect, since they get set in stone... and I'm told we should
> probably remove this one regulator from the device rather.
> I'm just uncertain.

Nothing is set in stone. I'm always happy to do clean-ups and code 
corrections. :)

Mark,

What's the answer?

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 18 Sep 2017 06:21:20 -0700
Subject: [PATCH 1/5] i2c: gpio: Convert to use descriptors
In-Reply-To: <59BF5483.9020403@denx.de>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
 <20170914093509.uwk47vt3wnm3rtqb@dell>
 <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
 <59BF5483.9020403@denx.de>
Message-ID: <0c3eaa74-6e94-825c-5830-2cfc71efaf4f@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2017 10:07 PM, Heiko Schocher wrote:
> Hello Linux,
> 
> Am 17.09.2017 um 00:25 schrieb Linus Walleij:
>> On Thu, Sep 14, 2017 at 11:35 AM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>>>> ? drivers/mfd/sm501.c????????????????????????? |? 49 +++++-----
>>>
>>> I'd prefer for this to be applied with a Tested-by.? I appreciate that
>>> this is an old driver, but can you attempt to contact one of the
>>> authors or someone else who might have hardware please?
>>
>> For SM501 specifically I guess.
>>
>> OK makes sense as it is the most invasive one, paging around...
>>
>> Ben, Ville, Magnus, Heiko, Guenther: is one of you still using this
>> hardware so you can test the patch set?
> 
> I am Sorry, I do not have the hardware anymore so no chance to test
> it :-(
> 

I had a look into the kernel and qemu code. The only machine actually using
it is an arm system names Anubis, which qemu does not support. No help here
either, sorry.

Guenter

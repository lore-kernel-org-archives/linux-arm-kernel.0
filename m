From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 16 Sep 2017 17:14:42 -0700
Subject: [PATCH 1/5] i2c: gpio: Convert to use descriptors
In-Reply-To: <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
 <20170914093509.uwk47vt3wnm3rtqb@dell>
 <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
Message-ID: <7f67dfa0-31da-0967-0929-28ae105bb2b5@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2017 03:25 PM, Linus Walleij wrote:
> On Thu, Sep 14, 2017 at 11:35 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
>>>   drivers/mfd/sm501.c                          |  49 +++++-----
>>
>> I'd prefer for this to be applied with a Tested-by.  I appreciate that
>> this is an old driver, but can you attempt to contact one of the
>> authors or someone else who might have hardware please?
> 
> For SM501 specifically I guess.
> 
> OK makes sense as it is the most invasive one, paging around...
> 
> Ben, Ville, Magnus, Heiko, Guenther: is one of you still using this
> hardware so you can test the patch set?
> 

qemu supports it. I _think_ my commit for this driver was to fix a warning
I saw when running some qemu test. Unfortunately, I have no idea how that
message was triggered in my tests, or in other words which qemu machine
actually uses it. I'll try to find out, but no promises.

Guenter

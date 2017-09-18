From: hs@denx.de (Heiko Schocher)
Date: Mon, 18 Sep 2017 07:07:15 +0200
Subject: [PATCH 1/5] i2c: gpio: Convert to use descriptors
In-Reply-To: <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
 <20170914093509.uwk47vt3wnm3rtqb@dell>
 <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
Message-ID: <59BF5483.9020403@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linux,

Am 17.09.2017 um 00:25 schrieb Linus Walleij:
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

I am Sorry, I do not have the hardware anymore so no chance to test
it :-(

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs at denx.de

From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 10 Apr 2014 23:17:28 +0200
Subject: [PATCH 04/15] pinctrl: sunxi: specify clk name when retrieving
 pinctrl pio clk
In-Reply-To: <CACRpkdbG-D5RXrrJs9LBEGs-1dydmfPKvCgNb4S2=BbBq3SxQw@mail.gmail.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>	<1397051478-4113-5-git-send-email-boris.brezillon@free-electrons.com>	<CACRpkdYW6b_37V40TRxs=7ecaWuV0X7_YJ4=-Psr9CG-cTb79w@mail.gmail.com>
 <CACRpkdbG-D5RXrrJs9LBEGs-1dydmfPKvCgNb4S2=BbBq3SxQw@mail.gmail.com>
Message-ID: <53470A68.6090005@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

On 10/04/2014 20:16, Linus Walleij wrote:
> On Thu, Apr 10, 2014 at 8:14 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Wed, Apr 9, 2014 at 3:51 PM, Boris BREZILLON
>> <boris.brezillon@free-electrons.com> wrote:
>>
>>> Specify base pio clk name when retrieving it using the CCF.
>>> This way we will avoid conflicts when introducing a second clk for the A31
>>> SoC.
>>>
>>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
>> Are you merging all these through ARM SoC?
>>
>> In that case
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> If it's OK to merge stand-alone tell me and I'll apply it to
>> the pinctrl tree.
> Hm there seems to be quite a few patches to pinctrl here...
>
> May I apply this and the others to the pinctrl tree simply?

Actually I made a v2 (and then a v3 https://lkml.org/lkml/2014/4/10/320
:-)) of this series, in which I removed all DT related stuff.
So, if you agree with these changes, I guess you can take them through
you tree.

Best Regards,

Boris

>
> As DTS files should be maintained separately I don't think
> it's important to keep driver and DTS file changes together.
>
> Yours,
> Linus Walleij

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

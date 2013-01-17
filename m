From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Jan 2013 11:44:31 +0100
Subject: [PATCH 2/3] gpio: pca953x: add support for pca9505
In-Reply-To: <50EEC2C6.9070109@free-electrons.com>
References: <1357493688-25061-1-git-send-email-gregory.clement@free-electrons.com>
 <1357493688-25061-3-git-send-email-gregory.clement@free-electrons.com>
 <CACRpkdYu63TZDpHrGkg0cdqFCrVH1PiNFX8FcrxB9S_Vk9r=kg@mail.gmail.com>
 <50EEC2C6.9070109@free-electrons.com>
Message-ID: <CACRpkdZv615BfG5Ai76UdigKonwAv6fisNL0Eiu3=sK-vJx9UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 2:31 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> On 01/10/2013 12:15 PM, Linus Walleij wrote:
>> On Sun, Jan 6, 2013 at 6:34 PM, Gregory CLEMENT
>> <gregory.clement@free-electrons.com> wrote:
>>
>>> Now that pca953x driver can handle GPIO expanders with more than 32
>>> bits this patch adds the support for the pca9505 which cam with 40
>>> GPIOs.
>>>
>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>
>> Applied, thanks.
>>
> Hello Linus,
>
> I think it is a little too early to apply this patch because the 1st
> one still have bug and is not yet applied.

OK pulled it out. Could have been an issue with Grant's and my synchronized
trees but we were lucky this time.

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Apr 2017 10:45:34 +0200
Subject: [PATCH v2] arm: dts: sun7i-a20-bananapi: name the GPIO lines
In-Reply-To: <60d2e24d-91c8-7563-9ecc-f203b12e0983@rempel-privat.de>
References: <CACRpkdYnK=7C=F5hZUo-nYv6Z+Pb+eT7vm1e4hL8N-QgJnuLfg@mail.gmail.com>
 <1470384404-6796-1-git-send-email-linux@rempel-privat.de>
 <CACRpkdZn7-SL5kmGn7Pysz=QiQFBEm8+c6bw=hE5F0CV4ct0RQ@mail.gmail.com>
 <60d2e24d-91c8-7563-9ecc-f203b12e0983@rempel-privat.de>
Message-ID: <CACRpkdZcnJ1eCNW4ZF_A4zbeCt3JcAuw-1meB_Pn7ctMy99B_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 7:11 AM, Oleksij Rempel <linux@rempel-privat.de> wrote:
> Am 08.08.2016 um 19:51 schrieb Linus Walleij:
>> On Fri, Aug 5, 2016 at 10:06 AM, Oleksij Rempel <linux@rempel-privat.de> wrote:
>>
>>> This names the GPIO lines on the Banana Pi board in accordance with
>>> the A20_Banana_Pi v1.4 Specification.
>>>
>>> This will make these line names reflect through to userspace
>>> so that they can easily be identified and used with the new
>>> character device ABI.
>>>
>>> Some care has been taken to name all lines, not just those used
>>> by the external connectors, also lines that are muxed into some
>>> other function than GPIO: these are named "[FOO]" so that users
>>> can see with lsgpio what all lines are used for.
>>>
>>> Ps: most of the text was taken from Linus Wallej patch.
>>>
>>> Cc: devicetree at vger.kernel.org
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: Chen-Yu Tsai <wens@csie.org>
>>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Yours,
>> Linus Walleij
>
> Hm... i assume this patch was lost. Should i resend it?

Yes, but I'm not applying DTS patches. Make sure that the
sunxi maintainers get it and merge it.

Yours,
Linus Walleij

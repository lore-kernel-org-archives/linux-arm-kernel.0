From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Mar 2017 09:53:21 +0100
Subject: [PATCH 2/3] pinctrl: meson-gxl: Fix inverted registers and add
 missing pins
In-Reply-To: <5e975901-b5d4-fdc8-9866-ad6bc9e3b599@baylibre.com>
References: <1488893462-7016-1-git-send-email-narmstrong@baylibre.com>
 <1488893462-7016-3-git-send-email-narmstrong@baylibre.com>
 <CACRpkdZ+x6vZQKfCoKD3dn-XzAxBBwMy=HF1Zi7SqXFWv28rZA@mail.gmail.com>
 <5e975901-b5d4-fdc8-9866-ad6bc9e3b599@baylibre.com>
Message-ID: <CACRpkdbuYOf1XHsAR0mstRGv+2n2S2Lmn6KAsbKNV=aOseukLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 10:49 AM, Neil Armstrong
<narmstrong@baylibre.com> wrote:
> On 03/15/2017 10:43 AM, Linus Walleij wrote:
>> On Tue, Mar 7, 2017 at 2:31 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>>> Fix some inverted bit numbers in some pinctrl groups and add missing pins
>>> and groups to be in pair with the GXBB pinctrl pins definition.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>
>> This does not apply on my fixes branch and possibly no other
>> v4.11-rc1-based branch. Can you please rebase it and resend?
>>
>> I guess this also needs queueing for fixes?
>>
>> Yours,
>> Linus Walleij
>>
>
> Hi Linus,
>
> Indeed, it depends on Martin's "pinctrl: meson: gxl: add the missing PWM pin definitions" posted earlier.

I merged the latest version of Martin's patch and it still does not
apply so could you rebase on the pinctrl "devel" branch and
resend?

Yours,
Linus Walleij

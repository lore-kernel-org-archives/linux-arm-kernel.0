From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Jul 2014 10:45:40 +0200
Subject: [PATCH 3/3] pinctrl: Introduce pinctrl driver for Qualcomm pm8xxx
In-Reply-To: <CAJAp7Ojgf6iuSKtRnvyTCOxj5AwDA6W4eOeCpsfRqGAxcMPM1w@mail.gmail.com>
References: <1404782785-1824-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1404782785-1824-4-git-send-email-bjorn.andersson@sonymobile.com>
 <CACRpkdYqzsbisK-X22dwCcLFdvRm6-uJjNoEjv-h1-Jn6Uy-iw@mail.gmail.com>
 <CAJAp7Ojgf6iuSKtRnvyTCOxj5AwDA6W4eOeCpsfRqGAxcMPM1w@mail.gmail.com>
Message-ID: <CACRpkdZynmMjzB78ZUvxMiBEK_Lox5j0+Z8qGf_jvK184BLwHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 12:48 AM, Bjorn Andersson <bjorn@kryo.se> wrote:
> On Wed, Jul 9, 2014 at 2:32 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Jul 8, 2014 at 3:26 AM, Bjorn Andersson
> [...]

>> "direction" also seems a bit bool ... even "output_value".
>>
>
> "direction" is 2 bits that can be both be set, unfortunately it's not entirely
> clear to me what's expected when setting both; so I've copied the logic as good
> as possible from the codeaurora driver.

Oh, can you do this?

u8 foo:2;

?

Yours,
Linus Walleij

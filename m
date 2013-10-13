From: olof@lixom.net (Olof Johansson)
Date: Sun, 13 Oct 2013 14:07:12 -0700
Subject: [PATCH] ARM: integrator: deactivate timer0 on the Integrator/CP
In-Reply-To: <CACRpkda3i9Q9U_1zsFPm=w3_mY077-WbByppmSk5KUt63neOQg@mail.gmail.com>
References: <1381151993-5450-1-git-send-email-linus.walleij@linaro.org>
 <20131007175118.GC17592@quad.lixom.net>
 <CACRpkdb3iwqE0GJGHOVJpdDveiX-MZ=XV4Xtxv6mKfs-1kbxaw@mail.gmail.com>
 <CACRpkda3i9Q9U_1zsFPm=w3_mY077-WbByppmSk5KUt63neOQg@mail.gmail.com>
Message-ID: <CAOesGMhTV+Qh3Cwjp1_ucT5L3QonvaA1gjnhBZH9URx-KEs5dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 13, 2013 at 2:02 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Oct 9, 2013 at 10:42 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Mon, Oct 7, 2013 at 7:51 PM, Olof Johansson <olof@lixom.net> wrote:
>>> On Mon, Oct 07, 2013 at 03:19:53PM +0200, Linus Walleij wrote:
>>
>>>> This fixes a long-standing Integrator/CP regression from
>>>> commit 870e2928cf3368ca9b06bc925d0027b0a56bcd8e
>>>> "ARM: integrator-cp: convert use CLKSRC_OF for timer init"
>> (...)
>>>> ---
>>>> ARM SoC folks: can you please apply this directly for fixes
>>>> if noone complains? Thanks.
>>>
>>> Certainly, but I'll give them a day or two to complain. Prod me if I haven't
>>> applied by Wednesday (and there has been no further discussion).
>>
>> Plonk!
>
> Bleep Bleep! Regression!

I was searching for the one patch that I couldn't remember about when
I sent the series today. This was it. Whoops.

I've applied this to fixes now, and it'll be part of the next pull
request sometime next week. Sorry for the delay.


-Olof

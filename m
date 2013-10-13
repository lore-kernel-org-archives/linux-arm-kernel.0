From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 13 Oct 2013 23:02:45 +0200
Subject: [PATCH] ARM: integrator: deactivate timer0 on the Integrator/CP
In-Reply-To: <CACRpkdb3iwqE0GJGHOVJpdDveiX-MZ=XV4Xtxv6mKfs-1kbxaw@mail.gmail.com>
References: <1381151993-5450-1-git-send-email-linus.walleij@linaro.org>
 <20131007175118.GC17592@quad.lixom.net>
 <CACRpkdb3iwqE0GJGHOVJpdDveiX-MZ=XV4Xtxv6mKfs-1kbxaw@mail.gmail.com>
Message-ID: <CACRpkda3i9Q9U_1zsFPm=w3_mY077-WbByppmSk5KUt63neOQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 9, 2013 at 10:42 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Oct 7, 2013 at 7:51 PM, Olof Johansson <olof@lixom.net> wrote:
>> On Mon, Oct 07, 2013 at 03:19:53PM +0200, Linus Walleij wrote:
>
>>> This fixes a long-standing Integrator/CP regression from
>>> commit 870e2928cf3368ca9b06bc925d0027b0a56bcd8e
>>> "ARM: integrator-cp: convert use CLKSRC_OF for timer init"
> (...)
>>> ---
>>> ARM SoC folks: can you please apply this directly for fixes
>>> if noone complains? Thanks.
>>
>> Certainly, but I'll give them a day or two to complain. Prod me if I haven't
>> applied by Wednesday (and there has been no further discussion).
>
> Plonk!

Bleep Bleep! Regression!

Yours,
Linus Walleij

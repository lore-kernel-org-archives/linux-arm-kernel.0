From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Oct 2013 10:42:01 +0200
Subject: [PATCH] ARM: integrator: deactivate timer0 on the Integrator/CP
In-Reply-To: <20131007175118.GC17592@quad.lixom.net>
References: <1381151993-5450-1-git-send-email-linus.walleij@linaro.org>
 <20131007175118.GC17592@quad.lixom.net>
Message-ID: <CACRpkdb3iwqE0GJGHOVJpdDveiX-MZ=XV4Xtxv6mKfs-1kbxaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 7, 2013 at 7:51 PM, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Oct 07, 2013 at 03:19:53PM +0200, Linus Walleij wrote:

>> This fixes a long-standing Integrator/CP regression from
>> commit 870e2928cf3368ca9b06bc925d0027b0a56bcd8e
>> "ARM: integrator-cp: convert use CLKSRC_OF for timer init"
(...)
>> ---
>> ARM SoC folks: can you please apply this directly for fixes
>> if noone complains? Thanks.
>
> Certainly, but I'll give them a day or two to complain. Prod me if I haven't
> applied by Wednesday (and there has been no further discussion).

Plonk!

Yours,
Linus Walleij

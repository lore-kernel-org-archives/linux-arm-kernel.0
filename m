From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Sep 2013 11:33:52 +0200
Subject: [PATCH 01/38] ARM: ux500: Remove PrimeCell IDs from Nomadik I2C
 DT nodes
In-Reply-To: <20130911081911.GI11227@lee--X1>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-2-git-send-email-lee.jones@linaro.org>
 <CAOesGMgySNLKo_H0h4MCbAWvyW0h2bWa96drWBpnhAYYQwH9mw@mail.gmail.com>
 <20130910153037.GA11227@lee--X1>
 <CAOesGMiBN5SaEY26SxGaw9E4ViR3cC0PcwNMEd4cLJZMfomprQ@mail.gmail.com>
 <CACRpkdY24uU=tXirJqrxLH-45ORFGybJOg-2tDOkpSmFUQUiiw@mail.gmail.com>
 <20130911081911.GI11227@lee--X1>
Message-ID: <CACRpkdY6v+LMggLBdfKc3VUPmRZXTf1zBi4a93EPhQeo21wMeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 10:19 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 11 Sep 2013, Linus Walleij wrote:
>
>> Weird, yeah there is something wrong on Torvalds' HEAD, with
>> earlyprint it says:
>>
>> Uncompressing Linux... done, booting the kernel.
>> Error: unrecognized/unsupported processor variant (0x412fc091).
>> This comes from arch/arm/kernel/head-common.S
>>
>> I'm trying to bisect and find out what is causing this...
>
> Ah nice. Keep us informed of any progress.

No it was something transient, after a clean rebuild it boots
just fine. :-/

I'll see if I can boot the same uImage on the Snowball too.

Linus Walleij

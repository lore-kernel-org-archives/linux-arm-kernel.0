From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Mar 2014 20:52:13 +0100
Subject: [PATCH v2] gpio: davinci: fix gpio selection for OF
In-Reply-To: <53234B68.5090300@ahsoftware.de>
References: <5316FFCE.1060603@ti.com>
 <1394018461-757-1-git-send-email-holler@ahsoftware.de>
 <CACRpkdaF=jc9Z1XZCtH8VPuih01t--qyV-sgH1R_ix0VM4RzVA@mail.gmail.com>
 <5322D529.4070904@ahsoftware.de>
 <CACRpkdaghneo1MvNCfxjTED+sJepHgeZCgmKsRteG9qrBNWAfQ@mail.gmail.com>
 <5322F82A.9000507@ahsoftware.de>
 <CACRpkdZscprsy7kyqHPUMEMYJ_TKgG2bYR7mdrG4hTDp1w1nDg@mail.gmail.com>
 <53234B68.5090300@ahsoftware.de>
Message-ID: <CACRpkdZ2+kfOim1OEWbYR_Tj36i+8HmYXh+nqO9h1Em8gqy=3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 7:33 PM, Alexander Holler <holler@ahsoftware.de> wrote:
> Am 14.03.2014 14:54, schrieb Linus Walleij:
>
>> On Fri, Mar 14, 2014 at 1:38 PM, Alexander Holler <holler@ahsoftware.de>
>> wrote:
>>
>>>> In that case it is hardly a fix that we need to rush out to the entire
>>>> world.
>>>
>>>
>>> And I thought the reason for -rc is actually to fix bugs. But I never
>>> understood the magical ways and timings patches make their way into
>>> mainline. ;)
>>
>>
>> OK so it works like this: early in the -rc cycle we fix any bugs,
>> documentation
>> or whatever. At this point it's *regressions* so the fix need to fix
>> something
>> that broke in the merge window (or an earlier merge window).
>
>
> Sorry, but I don't believe that. It's always time to fix regressions and
> bugs.

This thing is not binary. Please consult
Documentation/development-process/2.Process

In this case we are very late in the release cycle, the patch is not
a simple oneliner and I need some more backing proof to know it
is a reasonable fix to push at this time and will not cause new
problems.

So a few Tested-by's from the people using this driver would for
example convince me that it is solving a real problem for them
and it needs to go into fixes.

Yours,
Linus Walleij

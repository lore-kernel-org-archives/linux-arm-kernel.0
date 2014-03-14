From: holler@ahsoftware.de (Alexander Holler)
Date: Fri, 14 Mar 2014 19:33:12 +0100
Subject: [PATCH v2] gpio: davinci: fix gpio selection for OF
In-Reply-To: <CACRpkdZscprsy7kyqHPUMEMYJ_TKgG2bYR7mdrG4hTDp1w1nDg@mail.gmail.com>
References: <5316FFCE.1060603@ti.com>	<1394018461-757-1-git-send-email-holler@ahsoftware.de>	<CACRpkdaF=jc9Z1XZCtH8VPuih01t--qyV-sgH1R_ix0VM4RzVA@mail.gmail.com>	<5322D529.4070904@ahsoftware.de>	<CACRpkdaghneo1MvNCfxjTED+sJepHgeZCgmKsRteG9qrBNWAfQ@mail.gmail.com>	<5322F82A.9000507@ahsoftware.de>
 <CACRpkdZscprsy7kyqHPUMEMYJ_TKgG2bYR7mdrG4hTDp1w1nDg@mail.gmail.com>
Message-ID: <53234B68.5090300@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 14.03.2014 14:54, schrieb Linus Walleij:
> On Fri, Mar 14, 2014 at 1:38 PM, Alexander Holler <holler@ahsoftware.de> wrote:
>
>>> In that case it is hardly a fix that we need to rush out to the entire
>>> world.
>>
>> And I thought the reason for -rc is actually to fix bugs. But I never
>> understood the magical ways and timings patches make their way into
>> mainline. ;)
>
> OK so it works like this: early in the -rc cycle we fix any bugs, documentation
> or whatever. At this point it's *regressions* so the fix need to fix something
> that broke in the merge window (or an earlier merge window).

Sorry, but I don't believe that. It's always time to fix regressions and 
bugs.

> If it is a new feature that never worked in the first place I would
> not call that
> a regression. There are no existing users out there that can experience
> regressions from a previously working system.

I believe that no (stable) kernel should introduce new known bugs (if 
fixes are available) and I wouldn't make a difference if it's a new 
feature or not. Usually people don't care if something is new or not if 
it has bugs

Anyway, I'm just curious and try to understand, I have a fix. ;)

Regards,

Alexander Holler

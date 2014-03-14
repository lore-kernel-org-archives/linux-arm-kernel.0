From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Mar 2014 14:54:00 +0100
Subject: [PATCH v2] gpio: davinci: fix gpio selection for OF
In-Reply-To: <5322F82A.9000507@ahsoftware.de>
References: <5316FFCE.1060603@ti.com>
 <1394018461-757-1-git-send-email-holler@ahsoftware.de>
 <CACRpkdaF=jc9Z1XZCtH8VPuih01t--qyV-sgH1R_ix0VM4RzVA@mail.gmail.com>
 <5322D529.4070904@ahsoftware.de>
 <CACRpkdaghneo1MvNCfxjTED+sJepHgeZCgmKsRteG9qrBNWAfQ@mail.gmail.com>
 <5322F82A.9000507@ahsoftware.de>
Message-ID: <CACRpkdZscprsy7kyqHPUMEMYJ_TKgG2bYR7mdrG4hTDp1w1nDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 1:38 PM, Alexander Holler <holler@ahsoftware.de> wrote:

>> In that case it is hardly a fix that we need to rush out to the entire
>> world.
>
> And I thought the reason for -rc is actually to fix bugs. But I never
> understood the magical ways and timings patches make their way into
> mainline. ;)

OK so it works like this: early in the -rc cycle we fix any bugs, documentation
or whatever. At this point it's *regressions* so the fix need to fix something
that broke in the merge window (or an earlier merge window).

If it is a new feature that never worked in the first place I would
not call that
a regression. There are no existing users out there that can experience
regressions from a previously working system.

So this is why I'm a bit conservative.

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 May 2012 10:01:08 +0800
Subject: [PATCH 05/15] ARM: ux500: New DT:ed snowball_platform_devs for
 one-by-one device enablement
In-Reply-To: <4FC304F4.9020902@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-6-git-send-email-lee.jones@linaro.org>
 <4F967B01.2050807@linaro.org>
 <CACRpkdZoaoGYqgikd4RqhFToPzkEWb7fx8cmOTrrZcxeQOkROQ@mail.gmail.com>
 <4FC304F4.9020902@linaro.org>
Message-ID: <CACRpkdZiSW=4PhhuMCj8A8DTiExebq8Ae-jTuaF4a_Rp+1qm5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2012 at 12:54 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Looks like neither of these made it into Mainline, however subsequent
> patches which made changes to them did. This has caused some merge error,
> thus the code, especially in arch/arm/mach-ux500/cpu-db8500.c, but also in
> arch/arm/mach-ux500/board-mop500.c is quite wrong. :(

OK can you create a fixup patch for the 3.5-rc series and send it
to the ARM SoC tree?

Yours,
Linus Walleij

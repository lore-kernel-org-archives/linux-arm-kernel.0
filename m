From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 26 Sep 2014 10:52:37 +0200
Subject: [PATCH v3 0/5] vf610: Add GPIO support
In-Reply-To: <cover.1411662961.git.stefan@agner.ch>
References: <cover.1411662961.git.stefan@agner.ch>
Message-ID: <CACRpkdaOZ-mN3LrGKWzmtm0+SJaWdaz5LG5H9UYi_e9GQRvaDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 6:37 PM, Stefan Agner <stefan@agner.ch> wrote:

> This 3rd version of the GPIO support for Vybrid now also includes
> the wakeup support which was part of the suspend/resume patchset
> I sent earlier this week.
>
> Changes in v3:

I've already applied patch 1/5.

However I had to fix conflicts against the development branch and
from patch 2/5 and onward there are even more conflicts, the most
obvious is that the driver is moved to drivers/pinctrl/freescale, but
there are other conflicts as well.

Can you please rebase patches 2-5 onto my "devel" branch from
the pin control tree and resend, also collect ACKs.
https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

I saw there was still discussion on 2/5 as well, but I'm ready
to merge anything ACKed by Shawn.

Yours,
Linus Walleij

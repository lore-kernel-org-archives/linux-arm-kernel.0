From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Apr 2012 10:19:39 +0200
Subject: [PATCH 15/15] ARM: ux500: Enable PRCMU Timer 4 (clocksource) via
 Device Tree
In-Reply-To: <1334867804-31942-16-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-16-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaU+1XqXMRfv+3dTLCnw7J=dgFW394TNyAYuRUwupnD8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 10:36 PM, Lee Jones <lee.jones@linaro.org> wrote:

> In dbx500 based devices the PRCMU Timer 4 is used as a clocksource
> and sched_clock. Here we fetch all necessary addressing information
> required for correct PRCMU initialisation from the Device Tree
> instead of using hard-coded values.
>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This does not affect MFD so I can take it through ux500 and
ARM SoC.

But please split it in two: one touching mach-ux500 and one
messing with boot/dts/* please.

Thanks!
Linus Walleij

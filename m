From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Apr 2013 10:33:11 +0200
Subject: [PATCH v2 12/13] ARM: move sp804 and integrator timers to
 drivers/clocksource
In-Reply-To: <5165F476.7010807@gmail.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
 <1364854883-5961-13-git-send-email-robherring2@gmail.com>
 <515A179A.8020800@linaro.org> <515B3637.8090603@gmail.com>
 <515B7AC1.9090403@linaro.org> <5165F476.7010807@gmail.com>
Message-ID: <CACRpkda_57wCFTOXv9ijfKycGO7-y6gvJA+3N=mNaMpNKbMHgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 1:23 AM, Rob Herring <robherring2@gmail.com> wrote:

> I'm waiting until there is some clear direction on how or if to split up
> clksrc and clkevt drivers. So I will drop this patch for 3.10 unless you
> are okay with moving it to drivers/clocksource first and sorting out how
> to split things later.

No hurries.

What do you think about my proposal to create drivers/timer
and move the clocksource drivers in a subdir there?

Yours,
Linus Walleij

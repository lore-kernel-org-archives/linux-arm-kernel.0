From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Sep 2011 23:30:28 +0200
Subject: [PATCH 7/8] OMAP4: clock: Add CPU local timer clock node.
In-Reply-To: <1315459327-3285-8-git-send-email-santosh.shilimkar@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
	<1315459327-3285-8-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <CAKnu2Mp4QnQPwcGJCrfMqS6VcfvvvAxginjJkLG1mPLO0WJBUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/8 Santosh Shilimkar <santosh.shilimkar@ti.com>:

> Local timer clock is sourced from the CPU clock and hence changes
> along with CPU clock. These per CPU local timers are used as
> clock-events, so they need to be reconfigured on CPU frequency
> change as part of CPUfreq governor.

This requires patch 6956/2 right?
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6956/2

Can I add your Tested-by: to the patch as well?

Yours,
Linus Walleij

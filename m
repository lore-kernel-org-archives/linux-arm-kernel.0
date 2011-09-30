From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 30 Sep 2011 14:45:13 +0530
Subject: [PATCH 7/8] OMAP4: clock: Add CPU local timer clock node.
In-Reply-To: <CAKnu2Mp4QnQPwcGJCrfMqS6VcfvvvAxginjJkLG1mPLO0WJBUw@mail.gmail.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
	<1315459327-3285-8-git-send-email-santosh.shilimkar@ti.com>
	<CAKnu2Mp4QnQPwcGJCrfMqS6VcfvvvAxginjJkLG1mPLO0WJBUw@mail.gmail.com>
Message-ID: <CAMQu2gyBq61jcP1sLDEs8+zGfdAa6Pur1fSec9Wfzs48CX5zjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 3:00 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 2011/9/8 Santosh Shilimkar <santosh.shilimkar@ti.com>:
>
>> Local timer clock is sourced from the CPU clock and hence changes
>> along with CPU clock. These per CPU local timers are used as
>> clock-events, so they need to be reconfigured on CPU frequency
>> change as part of CPUfreq governor.
>
> This requires patch 6956/2 right?
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6956/2
>
> Can I add your Tested-by: to the patch as well?
>
Sure.

From: tom.leiming@gmail.com (Ming Lei)
Date: Fri, 27 Sep 2013 21:09:14 +0800
Subject: [PATCH] clockevent: exynos_mct: fix lockdep warning
In-Reply-To: <17472486.7GQJa9ux9F@amdc1227>
References: <1380120578-17458-1-git-send-email-tom.leiming@gmail.com>
 <5243823D.4040208@linaro.org> <17472486.7GQJa9ux9F@amdc1227>
Message-ID: <CACVXFVO=k-wJ2SrjVQ_k1JhtAOo0-rZ_M780rqGWCbKA8_1qBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 6:32 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>
> This is a fix that we may want to have, but it must be modified to take
> my regression fix[1] into account.
>
> [1] clocksource: exynos_mct: Set IRQ affinity when the CPU goes online
> http://thread.gmane.org/gmane.linux.kernel.samsung-soc/22511/focus=23418

OK, I will write and submit v1 against your patch.

Thanks,
-- 
Ming Lei

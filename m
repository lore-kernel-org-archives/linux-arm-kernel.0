From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Oct 2012 13:45:01 +0200
Subject: [PATCH 0/4] cpufreq: db8500: Use platform data to provide cpufreq
 table
In-Reply-To: <1348841814-13645-1-git-send-email-ulf.hansson@stericsson.com>
References: <1348841814-13645-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdb-SWkysKGQrJBL1hJLucQ=aN59Sfxe6rxrvtR0HsOJ_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 4:16 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Since the cpufreq table is dependant on the prmcu fw, it make sense to
> keep the table there. Moreover since the cpufreq is already a mfd child
> device added by the prcmu this make even more logic.

Better there than elsewhere.

> The next step after these patches will be to implement an "arm_clk" to be
> used from cpufreq to update the opp instead of using the prcmu opp API directly.
> This will then remove the last hard dependency to the prcmu API from cpufreq.

Sounds like a plan.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Is this going to be merged through the cpufreq tree or the MFD tree?

Yours,
Linus Walleij

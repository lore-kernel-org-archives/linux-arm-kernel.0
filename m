From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Sep 2012 14:51:52 +0200
Subject: [PATCH v2] ARM: smp_twd: reprogram twd based on clk notifier
In-Reply-To: <1347489895-16384-1-git-send-email-mturquette@linaro.org>
References: <20120912203223.3094.5354@nucleus>
 <1347489895-16384-1-git-send-email-mturquette@linaro.org>
Message-ID: <CACRpkdaraGcj10gBVU=aJFQR4ec+0_MrNP7=yBQZavQd0jJauQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 12:44 AM, Mike Turquette <mturquette@linaro.org> wrote:

> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Changes in v2:
>  * Kept the original CPUfreq notifier scheme in place for platforms that
>    have not adapted to the common clk framework yet

This looks good. We can always delete the cpufreq part
(which is a kinda hack anyway) once all OMAPs have
notifiers.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

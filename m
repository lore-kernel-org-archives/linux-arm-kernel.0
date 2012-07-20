From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 20 Jul 2012 12:06:50 +0530
Subject: [PATCH 1/3] ARM: add cpufreq transiton notifier to adjust
 loops_per_jiffy for smp
In-Reply-To: <1342713281-31114-2-git-send-email-shawn.guo@linaro.org>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAMQu2gz3XXQdG3T=jSboZ8cW-gKO33k7+OUPaQpjpUcnitk_RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2012 at 9:24 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> From: Richard Zhao <richard.zhao@linaro.org>
>
> If CONFIG_SMP, cpufreq skips loops_per_jiffy update, because different
> arch has different per-cpu loops_per_jiffy definition.
>
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
Nice. Avoids other driver duplicating this code.
May be you can keep Richard's credit in commit too.

FWIW, Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

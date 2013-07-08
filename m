From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 8 Jul 2013 09:40:54 +0530
Subject: [PATCH RFC 3/3] cpufreq: cpufreq-cpu0: clk rate-change notifiers
In-Reply-To: <1373247868-21444-4-git-send-email-mturquette@linaro.org>
References: <1373247868-21444-1-git-send-email-mturquette@linaro.org>
 <1373247868-21444-4-git-send-email-mturquette@linaro.org>
Message-ID: <CAOh2x=kAM98Qta5RquVVByR8jJ3=t+6fNZ4o4WSroVCCZi+0Cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 8, 2013 at 7:14 AM, Mike Turquette <mturquette@linaro.org> wrote:
> Removes direct handling of OPP tables and voltage regulators by calling
> of_clk_cpufreq_notifier_handler, introduced by commit "clk: cpufreq
> helper for voltage scaling".
>
> In the future this can help consolidate code found across similar
> CPUfreq drivers.
>
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-cpu0.c | 125 ++++++++---------------------------------
>  1 file changed, 22 insertions(+), 103 deletions(-)

Good patch, really gets lots of stuff out from cpufreq drivers.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

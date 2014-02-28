From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 28 Feb 2014 09:18:02 +0530
Subject: [PATCH v3 1/3] cpufreq: stats: Remove redundant cpufreq_cpu_get()
 call
In-Reply-To: <1393552716-9754-1-git-send-email-skannan@codeaurora.org>
References: <1393552716-9754-1-git-send-email-skannan@codeaurora.org>
Message-ID: <CAKohpomjtE7Rtrs-TgxtSo658+4p0AHLzr9niN1GnkkrDqTxTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 February 2014 07:28, Saravana Kannan <skannan@codeaurora.org> wrote:
> __cpufreq_stats_create_table always gets pass the valid and real policy
> struct. So, there's no need to call cpufreq_cpu_get() to get the policy
> again.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

All patches look fine now. Rafael you can queue them up as per your
convenience.

@Saravana: Though I am quite sure you still need my patches to get
your initial issue fixed. So, can you please get them tested as early
as possible, so that we can get them in for 3.14?

@Srivatsa: Your reviews will also help :)

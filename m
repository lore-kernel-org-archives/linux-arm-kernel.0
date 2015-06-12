From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 12 Jun 2015 09:39:20 +0100
Subject: [PATCH 2/6] clocksource: arm_global_timer: Migrate to new
 'set-state' interface
In-Reply-To: <54f346e663f605e2f078a3114de85ba281d1e6d0.1433768426.git.viresh.kumar@linaro.org>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
 <54f346e663f605e2f078a3114de85ba281d1e6d0.1433768426.git.viresh.kumar@linaro.org>
Message-ID: <557A9AB8.9060200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/06/15 14:40, Viresh Kumar wrote:
> Migrate arm_global_timer driver to the new 'set-state' interface
> provided by the clockevents core, the earlier 'set-mode' interface is
> marked obsolete now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/clocksource/arm_global_timer.c | 37 ++++++++++++++++------------------
>   1 file changed, 17 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index e6833771a716..29ea50ac366a 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
>
Hi Viresh,
Thanks for the patch,

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini

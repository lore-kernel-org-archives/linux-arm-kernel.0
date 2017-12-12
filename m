From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 12 Dec 2017 12:51:07 +0530
Subject: [PATCH v2 4/7] cpufreq: mvebu: Use dev_pm_opp_remove()
In-Reply-To: <20171207135616.23670-5-gregory.clement@free-electrons.com>
References: <20171207135616.23670-1-gregory.clement@free-electrons.com>
 <20171207135616.23670-5-gregory.clement@free-electrons.com>
Message-ID: <20171212072107.GI25177@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-12-17, 14:56, Gregory CLEMENT wrote:
> Since the introduction of this driver, the dev_pm_opp_remove() was
> added. So stop claiming we can't remove opp and use it in case of
> failure.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/cpufreq/mvebu-cpufreq.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

There is no reason for this patch to be part of your series. You should have
sent it separately. Please do it now.

And while you do it, you can add

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

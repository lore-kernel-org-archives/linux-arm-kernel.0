From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 1 Dec 2014 12:41:59 +0530
Subject: [PATCH 5/8] arm_big_little: free OPP table created during ->init()
In-Reply-To: <b5fca3025ec6411bb134306059c119b6b58f5ee2.1416910766.git.viresh.kumar@linaro.org>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
 <b5fca3025ec6411bb134306059c119b6b58f5ee2.1416910766.git.viresh.kumar@linaro.org>
Message-ID: <CAKohpom2tLb6Krq94xsU9ra22ErNV=j6f5QCoR3ctaRj43=Jcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On 25 November 2014 at 16:04, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> OPP layer now supports freeing of OPPs and we should free them once they aren't
> useful anymore.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/arm_big_little.c    | 7 ++++++-
>  drivers/cpufreq/arm_big_little.h    | 5 ++++-
>  drivers/cpufreq/arm_big_little_dt.c | 1 +
>  3 files changed, 11 insertions(+), 2 deletions(-)

Looks like you missed applying this one from this series ?

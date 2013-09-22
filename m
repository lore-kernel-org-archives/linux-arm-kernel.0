From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 22 Sep 2013 06:42:35 +0530
Subject: [PATCH v4 2/3] Cpufreq: s5pv210 cpufreq fixes for CCF
In-Reply-To: <1379785342-25107-3-git-send-email-m.krawczuk@partner.samsung.com>
References: <1379785342-25107-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1379785342-25107-3-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <CAKohpokEF_+d_G0LX76JK_dNBtYtAKPznWbDcwLen4pgQTOt6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 September 2013 23:12, Mateusz Krawczuk
<m.krawczuk@partner.samsung.com> wrote:
> Use common clock framework api to get clock.
>
> Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

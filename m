From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 9 May 2015 07:59:51 +0530
Subject: [PATCH 2/2] cpufreq: dt: allow driver to boot automatically
In-Reply-To: <1431115050-23693-2-git-send-email-balbi@ti.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com>
 <1431115050-23693-2-git-send-email-balbi@ti.com>
Message-ID: <CAKohpom6s4FJ=BSZq388xszLDC6Pz876vSgTzyo_EHdaxkSGjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 May 2015 at 01:27, Felipe Balbi <balbi@ti.com> wrote:
> by adding the missing MODULE_ALIAS(), cpufreq-dt
> can be autoloaded by udev/systemd.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

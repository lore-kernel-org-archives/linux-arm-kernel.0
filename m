From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 May 2014 11:47:21 +0530
Subject: [PATCH v5 6/7] ARM: Exynos: switch to using generic cpufreq-cpu0
 driver
In-Reply-To: <1400855260-6807-7-git-send-email-thomas.ab@samsung.com>
References: <1400855260-6807-1-git-send-email-thomas.ab@samsung.com>
 <1400855260-6807-7-git-send-email-thomas.ab@samsung.com>
Message-ID: <CAKohpokcvwXTnUGJH6w2vcoR9Kjcu0dN0CRHtpf1Ars10mGgyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 May 2014 19:57, Thomas Abraham <thomas.ab@samsung.com> wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
>
> Remove the platform device instantiation for Exynos specific cpufreq
> driver and add the platform device for cpufreq-cpu0 driver.
>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

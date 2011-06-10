From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 10 Jun 2011 12:14:00 +0530
Subject: [PATCH 4/5] ARM: EXYNOS4: Add SPDIF for SMDKV310
In-Reply-To: <1307687667-9127-5-git-send-email-ch.naveen@samsung.com>
References: <1307687667-9127-1-git-send-email-ch.naveen@samsung.com>
	<1307687667-9127-5-git-send-email-ch.naveen@samsung.com>
Message-ID: <BANLkTi=NPaw37BPadkA79uwsZkjjASFMrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 12:04 PM, Naveen Krishna Chatradhi
<ch.naveen@samsung.com> wrote:
> This patch adds spdif to the machine supported device list for
> SMDKV310.
>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> ---
> ?arch/arm/mach-exynos4/mach-smdkv310.c | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
> index 7e3ee6c..966c6f2 100644
> --- a/arch/arm/mach-exynos4/mach-smdkv310.c
> +++ b/arch/arm/mach-exynos4/mach-smdkv310.c
> @@ -190,6 +190,7 @@ static struct platform_device *smdkv310_devices[] __initdata = {
> ? ? ? ?&exynos4_device_pd[PD_CAM],
> ? ? ? ?&exynos4_device_pd[PD_TV],
> ? ? ? ?&exynos4_device_pd[PD_GPS],
> + ? ? ? &exynos4_device_spdif,
> ? ? ? ?&exynos4_device_sysmmu,
> ? ? ? ?&exynos4_device_pcm0,
> ? ? ? ?&samsung_asoc_dma,

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

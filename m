From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 18 Dec 2013 11:20:44 +0100
Subject: [GIT PULL 4/7] Samsung dev for v3.14
In-Reply-To: <52AE0F62.80409@samsung.com>
References: <52AE0F62.80409@samsung.com>
Message-ID: <201312181120.44544.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Am Sonntag, 15. Dezember 2013, 21:21:54 schrieb Kukjin Kim:
> The following changes since commit
> 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> 
>    Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-dev
> 
> for you to fetch changes up to 70bacadbd07248576290de40cc217c06f0f2d3c3:
> 
>    ARM: S3C64XX: Select CPU_V6K instead of CPU_V6 (2013-12-16 04:08:51
> +0900)
> 
> ----------------------------------------------------------------
> Samsung updates for v3.14
> - Skip eint_init() for pinctrl-exynos because of re-executing
> - Use CPU_V6K for S3C64XX(ARM1176JZF-s) instead of CPU_V6
> 
> ----------------------------------------------------------------
> Mateusz Krawczuk (1):
>        ARM: SAMSUNG: if detected device tree skip irq init for S5P
> 
> Tomasz Figa (1):
>        ARM: S3C64XX: Select CPU_V6K instead of CPU_V6
> 
>   arch/arm/Kconfig                     | 2 +-
>   arch/arm/plat-samsung/s5p-irq-eint.c | 4 ++++
>   2 files changed, 5 insertions(+), 1 deletion(-)

do you also have time for a look at at least the s3c2416/s3c2443 common clock 
patches for your second round you wrote about yesterday? :-)


Thanks
Heiko

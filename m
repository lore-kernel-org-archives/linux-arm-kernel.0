From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 29 Jun 2011 22:13:34 +0900
Subject: [PATCH 0/2] ARM: S5PV210: GONI board update for CIF camera support
In-Reply-To: <1308760452-30676-1-git-send-email-s.nawrocki@samsung.com>
References: <1308760452-30676-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <004601cc365e$5e2f5dd0$1a8e1970$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> This patchset adds platform data definition for NOON010PC30 camera sensor
> for GONI board and renames sclk_cam clocks on S5PV210 platform which is
> needed
> for FIMC media device driver.
> 
> The whole patches converting s5p-fimc to media controller API can be found
at:
> 
> http://git.infradead.org/users/kmpark/linux-2.6-samsung
> branch: s5p-fimc-next
> 
> Sylwester Nawrocki (2):
>   ARM: S5PV210: Rename sclk_cam clocks for FIMC media driver
>   ARM: S5PV210: Add support for NOON010PC30 sensor on GONI board
> 
>  arch/arm/mach-s5pv210/Kconfig     |    1 +
>  arch/arm/mach-s5pv210/clock.c     |    6 +---
>  arch/arm/mach-s5pv210/mach-goni.c |   52
> +++++++++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 4 deletions(-)
> 
> Created against for-next branch at:
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git

Looks ok to me, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

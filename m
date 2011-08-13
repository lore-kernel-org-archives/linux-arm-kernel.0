From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 13 Aug 2011 10:46:26 +0900
Subject: [PATCH 0/2] Fixes for S5PV210 PM
In-Reply-To: <1313144774-30607-1-git-send-email-a.kesavan@samsung.com>
References: <1313144774-30607-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <000001cc595a$d1f45080$75dcf180$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash Kesavan wrote:
> 
> This patchset fixes a compilation warning and removes an unwanted
> Kconfig symbol.
> 
> Abhilash Kesavan (2):
>   ARM: S5PV210: Fix build warning
>   ARM: S5PV210: Remove unncessary symbol for PM
> 
>  arch/arm/mach-s5pv210/Kconfig  |    6 ------
>  arch/arm/mach-s5pv210/Makefile |    2 +-
>  arch/arm/mach-s5pv210/pm.c     |    2 +-
>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> --
> 1.7.4.1

Looks ok, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

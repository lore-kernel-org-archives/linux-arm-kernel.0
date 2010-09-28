From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 28 Sep 2010 21:07:09 +0900
Subject: [PATCH 0/4] Updata S5PC110 GONI board
In-Reply-To: <4C6CF047.7080507@samsung.com>
References: <4C6CF047.7080507@samsung.com>
Message-ID: <007f01cb5f05$b1019fe0$1304dfa0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joonyoung Shim wrote:
> 
> Hi,
> 
Hi,

> This patchset is to update GONi board.
> Kyungmin sent partial one of this patchset but this is more updated
> version.
> 
> Thanks.
> 
> 
> Joonyoung Shim (2):
>        ARM: S5PC110: Add keypad device to the GONI board
>        ARM: S5PC110: Add si470x radio device to the GONI board
> 

Could you please re-send following two patches?
- keypad device patch already has been merged in my tree.
- si470x radio patch has been included in Marek's patches

And I think need to update handling of gpio_request returning in the TSP
patch.

> Kyungmin Park (2):
>        ARM: S5PC110: GONI: Add TSP driver
>        ARM: S5PC110: GONI: Fixed voltage support for eMMC
> 
>   arch/arm/mach-s5pv210/Kconfig     |    6 ++
>   arch/arm/mach-s5pv210/mach-goni.c |  156
> +++++++++++++++++++++++++++++++++++++
>   2 files changed, 162 insertions(+), 0 deletions(-)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

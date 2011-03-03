From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 03 Mar 2011 13:33:01 +0900
Subject: [PATCH 1/3] ARM: S5P: Rename MIPI-CSIS header and update Copyright
In-Reply-To: <1299087289-29926-2-git-send-email-s.nawrocki@samsung.com>
References: <1299087289-29926-1-git-send-email-s.nawrocki@samsung.com>
	<1299087289-29926-2-git-send-email-s.nawrocki@samsung.com>
Message-ID: <01a501cbd95c$37069cf0$a513d6d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-s5p/dev-csis0.c              |    2 +-
>  arch/arm/plat-s5p/dev-csis1.c              |    2 +-
>  arch/arm/plat-s5p/include/plat/csis.h      |   28
--------------------------
> --
>  arch/arm/plat-s5p/include/plat/mipi_csis.h |   28
> ++++++++++++++++++++++++++++
>  4 files changed, 30 insertions(+), 30 deletions(-)
>  delete mode 100644 arch/arm/plat-s5p/include/plat/csis.h
>  create mode 100644 arch/arm/plat-s5p/include/plat/mipi_csis.h
> 
Oops, why didn't use '-M'?
It can show me this like following.

.../plat-s5p/include/plat/{csis.h => mipi_csis.h}  |   10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/arm/plat-s5p/include/plat/{csis.h => mipi_csis.h} (68%)

Secondly, I remember this...
Following is your response at that time.
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-January/038037.ht
ml

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

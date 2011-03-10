From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 10 Mar 2011 20:13:17 +0900
Subject: [PATCH v3 1/3] ARM: S5P: Rename MIPI-CSIS driver header and update
	Copyright
In-Reply-To: <1299755195-9055-2-git-send-email-s.nawrocki@samsung.com>
References: <002601cbdead$0f1cb840$2d5628c0$%kim@samsung.com>
	<1299755195-9055-2-git-send-email-s.nawrocki@samsung.com>
Message-ID: <008c01cbdf14$2c6d6d60$85484820$%kim@samsung.com>
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
Sylwester,

Oops...I remember, already said, if you use -M, you can see following.

arch/arm/plat-s5p/dev-csis0.c                      |    2 +-
 arch/arm/plat-s5p/dev-csis1.c                      |    2 +-
 .../plat-s5p/include/plat/{csis.h => mipi_csis.h}  |   10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/arm/plat-s5p/include/plat/{csis.h => mipi_csis.h} (68%)

Please don't test my patience :(

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

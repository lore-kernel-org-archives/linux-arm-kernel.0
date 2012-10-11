From: nm@ti.com (Nishanth Menon)
Date: Thu, 11 Oct 2012 08:33:04 -0500
Subject: [RFC][PATCH v4? 0/7] Adaptive Body-Bias for OMAP
In-Reply-To: <1349313974-5473-1-git-send-email-mturquette@ti.com>
References: <1349313974-5473-1-git-send-email-mturquette@ti.com>
Message-ID: <20121011133304.GA19170@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:26-20121003, Mike Turquette wrote:
> From: Mike Turquette <mturquette@linaro.org>
[...]
> 
>  arch/arm/mach-omap2/Makefile                  |    8 +-
>  arch/arm/mach-omap2/abb.c                     |  322 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/abb.h                     |   94 ++++++++
[...]
>  arch/arm/plat-omap/include/plat/voltage.h     |    1 +
>  18 files changed, 699 insertions(+), 37 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/abb.c
>  create mode 100644 arch/arm/mach-omap2/abb.h
>  create mode 100644 arch/arm/mach-omap2/abb36xx_data.c
>  create mode 100644 arch/arm/mach-omap2/abb44xx_data.c

dumb question: with the request to move everything out of mach-omap2
directory, do we still want to add more files into mach-omap2?

Regards,
NM

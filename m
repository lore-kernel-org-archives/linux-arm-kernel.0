From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 10 Jun 2014 13:43:31 +0200
Subject: [PATCH v4 01/11] ARM: EXYNOS: Make exynos machine_ops as static
In-Reply-To: <1399704998-13321-2-git-send-email-pankaj.dubey@samsung.com>
References: <1399704998-13321-1-git-send-email-pankaj.dubey@samsung.com>
 <1399704998-13321-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <5396EF63.8030506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 10.05.2014 08:56, Pankaj Dubey wrote:
> As machine function ops are used only in this file let's make
> them static. Also remove unused and unwanted declarations from
> common.h.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h |    8 --------
>  arch/arm/mach-exynos/exynos.c |    6 +++---
>  2 files changed, 3 insertions(+), 11 deletions(-)
> 

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz

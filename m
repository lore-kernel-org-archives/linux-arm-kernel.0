From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 08 Jul 2014 16:25:49 +0200
Subject: [PATCH v6 1/4] ARM: EXYNOS: Add support for mapping PMU base
 address via DT
In-Reply-To: <1404710376-16448-2-git-send-email-pankaj.dubey@samsung.com>
References: <1404710376-16448-1-git-send-email-pankaj.dubey@samsung.com>
 <1404710376-16448-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53BBFF6D.8070203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.07.2014 07:19, Pankaj Dubey wrote:
> Add support for mapping Samsung Power Management Unit (PMU)
> base address from device tree.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h |    1 +
>  arch/arm/mach-exynos/exynos.c |   37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 

Thanks for keeping up with addressing the comments.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

--
Best regards,
Tomasz

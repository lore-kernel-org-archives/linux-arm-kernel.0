From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 18 Aug 2014 14:14:18 +0200
Subject: [PATCH v3 2/2] ARM: EXYNOS: Refactor the pm code to use DT based
 lookup
In-Reply-To: <1407412789-1919-3-git-send-email-vikas.sajjan@samsung.com>
References: <1407412789-1919-1-git-send-email-vikas.sajjan@samsung.com>
 <1407412789-1919-3-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <53F1EE1A.4000305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vikas,

On 07.08.2014 13:59, Vikas Sajjan wrote:
> Refactoring the pm.c to avoid using "soc_is_exynos" checks,
> instead use the DT based lookup.
> 
> While at it, consolidate the common code across SoCs
> and create a static helper functions.
> 
> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
> ---
>  arch/arm/mach-exynos/pm.c       |  168 +++++++++++++++++++++++++++++----------
>  arch/arm/mach-exynos/regs-pmu.h |    1 +
>  2 files changed, 126 insertions(+), 43 deletions(-)
> 

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomas

From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 31 Aug 2012 09:21:05 +0530
Subject: [PATCH 2/6] ARM: EXYNOS: exynos4-dt: Use exynos4 prefix instead
 of exynos4210
In-Reply-To: <1346311903-15920-3-git-send-email-t.figa@samsung.com>
References: <1346311903-15920-1-git-send-email-t.figa@samsung.com>
 <1346311903-15920-3-git-send-email-t.figa@samsung.com>
Message-ID: <CAJuYYwTcAjgqLgp0tLSu-Tms1JEAk0WMjYC-Gx3YK1JVOm4VFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 August 2012 13:01, Tomasz Figa <t.figa@samsung.com> wrote:
> Since mach-exynos4-dt.c is also going to be used for other SoCs from Exynos4
> line, rename internal structures and functions to use exynos4_ prefix, instead
> of exynos4210_.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/mach-exynos4-dt.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Thomas Abraham <thomas.abraham@linaro.org>

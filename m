From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 25 Jan 2017 22:04:34 +0200
Subject: [PATCH 7/7] mfd: exynos-lpass: Add runtime PM support
In-Reply-To: <1485345031-2948-8-git-send-email-m.szyprowski@samsung.com>
References: <1485345031-2948-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115105eucas1p1e7191cf0be871c254dd09477ca7f9e1a@eucas1p1.samsung.com>
 <1485345031-2948-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170125200434.zhyjhffyftp4cfth@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 12:50:31PM +0100, Marek Szyprowski wrote:
> Convert exisitng lpass-suspend/resume callbacks into runtime PM callbacks.
> This way Exynos LPASS driver will be ready for use with power domains
> enabled. LPASS will be runtime resumed/suspended as a result of its child
> devices runtime PM transitions.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/mfd/exynos-lpass.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

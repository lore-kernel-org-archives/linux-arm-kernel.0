From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 11 Mar 2015 10:15:35 -0700
Subject: [PATCH v2] ARM: EXYNOS: Use platform device name as power domain
 name
In-Reply-To: <1426067672-21589-1-git-send-email-k.kozlowski@samsung.com>
 (Krzysztof Kozlowski's message of "Wed, 11 Mar 2015 10:54:32 +0100")
References: <1426067672-21589-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <7h61a7xxoo.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> The power domain nodes in DTS may be very generic (e.g. "power-domain"
> for Exynos 5420) making it very hard to debug:
>
> $ cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
>     domain                      status         slaves
> power-domain                    on
>
> Use platform device name instead so the names will be a little more user
> friendly:
>     domain                      status         slaves
> 100440e0.power-domain           on
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Suggested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Reviewed-by: Kevin Hilman <khilman@linaro.org>

I still think we need some more detail as wel, but this is a good step
in the right direction.

Kevin

From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 15 May 2015 22:22:39 +0900
Subject: [PATCH v2] ARM: dts: Add syscon property to the MIPI phy in
 exynos5420
In-Reply-To: <1431607240-14549-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1431607240-14549-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAJKOXPd7=wnjCd6Xz9ZNuvbxWi=cSr+eRj9YdPWA0PHR+AOTeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-14 21:40 GMT+09:00 Tomeu Vizoso <tomeu.vizoso@collabora.com>:
> Since e4b3d38088df6f3acd40 ("phy: exynos-video-mipi: Fix regression by
> adding support for PMU regmap") the syscon property is required in
> samsung,s5pv210-mipi-video-phy nodes, but this DTS hadn't been updated
> yet.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Krzysztof Koz?owski <k.kozlowski@samsung.com>
>
> --

Triple-dash please, because this won't be cut by "git am".

Everything else looks fine, thank you.
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

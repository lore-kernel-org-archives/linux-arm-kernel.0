From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 16 Oct 2018 15:06:52 +0200
Subject: [PATCH v2 6/6] arm64: platform: Add enable Exynos Multi-Core
 Timer driver
In-Reply-To: <20181015123112.9379-7-m.szyprowski@samsung.com>
References: <CGME20181015123137eucas1p1cf043644b9b40e15c9d2f221f26bef51@eucas1p1.samsung.com>
 <20181015123112.9379-1-m.szyprowski@samsung.com>
 <20181015123112.9379-7-m.szyprowski@samsung.com>
Message-ID: <CAJKOXPfEUVFYCpWiNVWWLydM6pisTEvDPk1OJnY2CC7z7Zt_Cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Oct 2018 at 14:31, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On Exynos SoCs enabling MCT driver is required even if ARM Architected
> Timer driver is used to for managing timer hardware and clock source
> events.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)

Looks okay, I'll take it after this merge window.

In case this was applied directly to arm-soc:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

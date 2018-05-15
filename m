From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 15 May 2018 19:39:24 +0200
Subject: [PATCH v2] ARM: dts: exynos: Add support for audio over HDMI for
 Odroid X/X2/U3
In-Reply-To: <20180514080148.10150-1-s.nawrocki@samsung.com>
References: <CGME20180514080220epcas2p110497f1deca1e9c10db9b9edb890d76b@epcas2p1.samsung.com>
 <20180514080148.10150-1-s.nawrocki@samsung.com>
Message-ID: <20180515173924.goxxl4wic7tlhzyw@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 10:01:48AM +0200, Sylwester Nawrocki wrote:
> This patch switches Odroid X/X2/U3 to use dedicated Odroid audio subsystem
> DT bindings instead of the simple-card in order to add support for audio
> over HDMI.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 33 +++++++++++++++----------
>  arch/arm/boot/dts/exynos4412-odroidu3.dts       |  6 ++---
>  arch/arm/boot/dts/exynos4412-odroidx.dts        |  6 ++---
>  3 files changed, 26 insertions(+), 19 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof

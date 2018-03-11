From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 11 Mar 2018 18:44:09 +0100
Subject: [PATCH v3 3/6] ARM: dts: exynos: Update of the max98095 node in
 exynos5250-snow.dts
In-Reply-To: <20180309172250.23019-3-s.nawrocki@samsung.com>
References: <20180309172250.23019-1-s.nawrocki@samsung.com>
 <CGME20180309172414epcas1p36b0c39ad993afcad7f8cf8941cc6bf68@epcas1p3.samsung.com>
 <20180309172250.23019-3-s.nawrocki@samsung.com>
Message-ID: <20180311174409.wx5zfskvh7zbnivz@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2018 at 06:22:47PM +0100, Sylwester Nawrocki wrote:
> This patch adds missing clocks, clock-names properties so the CODEC can
> properly handle its master clock. Without this change sound on exynos5250-snow
> doesn't work.
> Missing #sound-dai-cells property is also added so it is possible to specify
> the DAI links properly for HDMI audio support.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1:
>  - edited commit summary line.
> ---
>  arch/arm/boot/dts/exynos5250-snow.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof

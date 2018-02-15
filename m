From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 15 Feb 2018 19:32:57 +0100
Subject: [PATCH v3 3/3] ARM: dts: exynos: Add support for HDMI audio on
 exynos5433-tm2
In-Reply-To: <20180212163147.11561-3-s.nawrocki@samsung.com>
References: <20180212163147.11561-1-s.nawrocki@samsung.com>
 <CGME20180212163212epcas2p15a43c33e24b6c800544637ca0b030cb6@epcas2p1.samsung.com>
 <20180212163147.11561-3-s.nawrocki@samsung.com>
Message-ID: <20180215183257.lvtyzixgzwfcl7fq@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 05:31:47PM +0100, Sylwester Nawrocki wrote:
> This patch updates the sound node of the exynos5433-tm2 board
> and adds clock tree configuration in order to support HDMI sound.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v2:
>  - nodes sorted alphabetically, changed the assigned clock
>    frequencies.
> 
> Changes since v1:
>  - dropped unnecessary assigned-clock* properties for AUD PLL
>    in cmu_top node,
>  - changed default AUD PLL frequency so it is within recommended
>    252...400 MHz range.
> ---
>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 52 ++++++++++++++++++++--
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  1 +
>  2 files changed, 49 insertions(+), 4 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof

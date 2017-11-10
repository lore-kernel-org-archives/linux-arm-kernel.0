From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 10 Nov 2017 18:15:56 +0100
Subject: [PATCH v2 2/2] ARM: dts: exynos: Add sound support for Odroid XU4
In-Reply-To: <20171103165446.15438-3-s.nawrocki@samsung.com>
References: <20171103165446.15438-1-s.nawrocki@samsung.com>
 <CGME20171103165612epcas2p38df1787630b2dfbf1d0d0e3ef1b93a49@epcas2p3.samsung.com>
 <20171103165446.15438-3-s.nawrocki@samsung.com>
Message-ID: <20171110171556.7ecu4cd4u7vnwhop@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 05:54:46PM +0100, Sylwester Nawrocki wrote:
> This patch adds support for Odroid XU4 audio. The main difference
> comparing to Odroid XU3 is a missing on-board audio CODEC, only
> HDMI output is supported on Odroid XU4. External CODEC could be
> optionally connected to the I2S port connector.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu4.dts | 52 ++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>

Looks good, I will take it after merge window. For my own reference:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

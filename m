From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 11 Mar 2018 18:43:44 +0100
Subject: [PATCH v3 5/6] ARM: dts: exynos: Enable HDMI audio support on
 exynos5420-peach-pit
In-Reply-To: <20180309172250.23019-5-s.nawrocki@samsung.com>
References: <20180309172250.23019-1-s.nawrocki@samsung.com>
 <CGME20180309172442epcas2p16d82d119fea8471383ccacee501c539a@epcas2p1.samsung.com>
 <20180309172250.23019-5-s.nawrocki@samsung.com>
Message-ID: <20180311174344.uxks3ebf56cuwdyx@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2018 at 06:22:49PM +0100, Sylwester Nawrocki wrote:
> This patch adds new cpu, codec subnodes according to the updated
> "google,snow-audio-max98090" DT bindings and the I2S clock tree
> configuration so sound on the HDMI interface can also be supported.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1:
>  - edited commit summary line.
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof

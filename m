From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 12 Dec 2017 18:47:08 +0100
Subject: [PATCH v2] ARM: dts: exynos: Enable Mixer node for Exynos5800
 Peach Pi machine
In-Reply-To: <20171212074208.30753-1-javierm@redhat.com>
References: <20171212074208.30753-1-javierm@redhat.com>
Message-ID: <20171212174708.miyqt2gtcanumgow@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 08:42:08AM +0100, Javier Martinez Canillas wrote:
> Commit 1cb686c08d12 ("ARM: dts: exynos: Add status property to Exynos 542x
> Mixer nodes") disabled the Mixer node by default in the DTSI and enabled
> for each Exynos 542x DTS. But unfortunately it missed to enable it for the
> Exynos5800 Peach Pi machine, since the 5800 is also an 542x SoC variant.
> 
> Fixes: 1cb686c08d12 ("ARM: dts: exynos: Add status property to Exynos 542x Mixer nodes")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> ---
> 
> Changes in v2:
> - Remove RFT tag.
> - Add Marek's Acked-by tag.
> - Add fixes tag.
> 
>  arch/arm/boot/dts/exynos5800-peach-pi.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Thanks, applied for current cycle (fixes).

Best regards,
Krzysztof

From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 5 Nov 2016 17:41:37 +0200
Subject: [PATCH 2/4] ARM: dts: exynos: Add SCU device node to exynos4.dtsi
In-Reply-To: <1478230764-13748-3-git-send-email-pankaj.dubey@samsung.com>
References: <1478230764-13748-1-git-send-email-pankaj.dubey@samsung.com>
 <1478230764-13748-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20161105154137.GB8183@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 09:09:22AM +0530, Pankaj Dubey wrote:
> Exynos4 like other Cortex-A9 SoC's has a Snoop Control Unit(SCU)
> and its SFR are used during SMP boot and S2R. Add SCU node to the device tree.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof

From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 20 Nov 2015 09:20:49 +0900
Subject: [PATCH v2 2/6] arm: dts: Add syscon-{reboot,
 poweroff} nodes for exynos4
In-Reply-To: <1445333085-22837-3-git-send-email-alim.akhtar@samsung.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
 <1445333085-22837-3-git-send-email-alim.akhtar@samsung.com>
Message-ID: <564E6761.7000805@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.10.2015 18:24, Alim Akhtar wrote:
> This patch adds syscon-{reboot, poweroff} nodes to allow the
> generic syscon-{reboot, poweroff} driver to reset/poweroff exynos4 SoC.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Tested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
>  arch/arm/boot/dts/exynos4.dtsi |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

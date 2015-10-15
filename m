From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 15 Oct 2015 10:38:54 +0900
Subject: [PATCH v1 2/2] ARM: dts: exynos5250: Add clocks to DISP1 domain
In-Reply-To: <1444819457-27519-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1444819457-27519-1-git-send-email-tomeu.vizoso@collabora.com>
 <1444819457-27519-3-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <561F03AE.8020504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.10.2015 19:44, Tomeu Vizoso wrote:
> Adds to the node of the DISP1 power domain the two clocks that need to
> be reparented while the domain is powered off:
> CLK_MOUT_ACLK200_DISP1_SUB and CLK_MOUT_ACLK300_DISP1_SUB.
> 
> Otherwise the state is unknown at power up and the mixer's clocks are
> all messed up.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Link: http://lkml.kernel.org/g/561CDC33.7050103 at collabora.com
> ---
> 
>  arch/arm/boot/dts/exynos5250.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Looks good:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

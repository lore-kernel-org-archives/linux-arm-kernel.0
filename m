From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Jun 2017 18:20:47 +0200
Subject: [PATCH v2 3/4] ARM: dts: exynos: Fix the active of reset gpios
 from rinato dts
In-Reply-To: <1497521010-8429-4-git-send-email-hoegeun.kwon@samsung.com>
References: <1497521010-8429-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170615100342epcas1p4feeb3d12bb9e120bf40dc5945c4b2460@epcas1p4.samsung.com>
 <1497521010-8429-4-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170616162047.mrm73b2cd4ffovox@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 07:03:29PM +0900, Hoegeun Kwon wrote:
> This reset gpios is active low, therefore fix from active high to low.
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250-rinato.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks, applied this one only. As mentioned before, 4/4 will wait for
driver.

Best regards,
Krzysztof

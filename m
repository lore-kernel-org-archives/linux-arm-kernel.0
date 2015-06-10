From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 10 Jun 2015 14:27:24 +0900
Subject: [PATCHv2] ARM: exynos_defconfig: Enable CONFIG_SND_SOC_ODROIDX2
 for Odroid-XU3
In-Reply-To: <1433822879-3908-1-git-send-email-linux.amoon@gmail.com>
References: <1433822879-3908-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <5577CABC.9000609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.06.2015 13:07, Anand Moon wrote:
> Enable CONFIG_SND_SOC_ODROIDX2 and CONFIG_SND_SIMPLE_CARD to enable
> sound on Odroid-XU3 board using the max98090 audio codec.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
> Changes v2: Fixed the commit log.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Thanks, applied.

I'll send later to Kukjin for 4.3.
Unless he picks it also, in that case:
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

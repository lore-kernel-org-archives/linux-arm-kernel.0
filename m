From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 13 Aug 2015 19:14:51 +0900
Subject: [PATCH v2] ARM: dts: exynos4412-odroidu3: Enable SPI1.
In-Reply-To: <1439456813-4918-1-git-send-email-aballier@gentoo.org>
References: <1439456813-4918-1-git-send-email-aballier@gentoo.org>
Message-ID: <55CC6E1B.2050707@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 13.08.2015 o 18:06, Alexis Ballier pisze:
> SPI1 is available on IO Port #2 (as depicted on their website) in
> PCB Revision 0.5 of Hardkernel Odroid U3 board.
> The shield connects a 256KiB spi-nor flash on that bus.
> 
> Signed-off-by: Alexis Ballier <aballier@gentoo.org>
> 
> ---
> 
> Changes in v2: Use GPIO_ACTIVE_HIGH (Krzysztof Kozlowski)
> 
>  arch/arm/boot/dts/exynos4412-odroidu3.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)

Thanks for fixing, looks good:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

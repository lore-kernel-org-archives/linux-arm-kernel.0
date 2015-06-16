From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Jun 2015 20:05:58 +0900
Subject: [PATCHv7 2/4] ARM: dts: exynos5422-odroidxu3: Enable TMU at
 Exynos5422 base
In-Reply-To: <1434336803-4132-2-git-send-email-linux.amoon@gmail.com>
References: <1434336803-4132-1-git-send-email-linux.amoon@gmail.com>
 <1434336803-4132-2-git-send-email-linux.amoon@gmail.com>
Message-ID: <55800316.9050406@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 15.06.2015 o 11:53, Anand Moon pisze:
> This changes enables TMU IP block on the Exynos5422 Odroid-XU3
> device.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> Acked-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
> Changes rebase on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung branch for-next
> Changes from v5 and v6: Use LDO7 regulator instead of LDO10 regulator to control TMU.
> 	Fixed the commit log.
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Thanks Anand for working on this!

Whole patchset tested on Odroid XU3-Lite board:
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

I already acked other patches, except this one:
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

I'll apply this to my tree and send for v4.3 to Kukjin (unless he picks
it also).

Best regards,
Krzysztof

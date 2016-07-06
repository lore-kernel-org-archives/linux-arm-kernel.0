From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 06 Jul 2016 08:03:24 +0200
Subject: [PATCH] arm64: defconfig: Enable s2mps11 regulator clk and s3c rtc
 driver
In-Reply-To: <1467713211-16014-1-git-send-email-alim.akhtar@samsung.com>
References: <1467713211-16014-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <577C9F2C.4040509@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2016 12:06 PM, Alim Akhtar wrote:
> The s3c rtc controller on exynos7 platform uses rtc source clock
> from s2mps11 pmic. This patch enables the required bits to make
> rtc work on exynos7-espresso board.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm64/configs/defconfig |    2 ++
>  1 file changed, 2 insertions(+)

Thanks, applied, with changed commit title and message. Any more arm64
defconfig changes coming soon?

Best regards,
Krzysztof

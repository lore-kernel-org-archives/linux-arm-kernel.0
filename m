From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 06 Jul 2016 08:21:40 +0200
Subject: [PATCH] arm64: dts: Fix rtc by providing rtc_src clock
In-Reply-To: <1467713107-15932-1-git-send-email-alim.akhtar@samsung.com>
References: <1467713107-15932-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <577CA374.4000900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2016 12:05 PM, Alim Akhtar wrote:
> Add rtc source clock as exynos7 needs source (32.768KHz) clock
> for rtc block. Without this currently rtc driver probe is broken
> on this SoC, thats because rtc-s3c driver expect rtc_src clock to
> be provided for _s3c6410-rtc_ type rtc controllers.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts |    3 +++
>  1 file changed, 3 insertions(+)

Thanks, applied with adjusted message. I'll send it as a fix for v4.7.

Best regards,
Krzysztof

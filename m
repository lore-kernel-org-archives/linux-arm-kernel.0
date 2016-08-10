From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 10 Aug 2016 16:02:26 +0200
Subject: [[PATCH v2] 05/11] ARM: EXYNOS: Enable ARCH_SUPPORTS_BIG_ENDIAN
 explicitly
In-Reply-To: <1466504432-24187-6-git-send-email-ben.dooks@codethink.co.uk>
References: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
 <1466504432-24187-6-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <7a289a51-52de-59a1-f147-2d01900f5fed@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2016 12:20 PM, Ben Dooks wrote:
> Now the initial fixes have the big-endian code working on EXYNOS, make sure
> we explicitly mark our arch as being big endian capable.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/mach-exynos/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied.

Best regards,
Krzysztof

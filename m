From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 25 Feb 2016 13:26:59 +0900
Subject: [PATCH v2 0/2] ARM: EXYNOS: Trivial cleanup samsung mach files
In-Reply-To: <1456373400-10633-1-git-send-email-pankaj.dubey@samsung.com>
References: <1456373400-10633-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <56CE8293.2050901@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.02.2016 13:09, Pankaj Dubey wrote:
> This patch series cleans up mach-exynos, mach-s3c24xx, plat-samsung include
> header files with resepct to unused header file inclusion, removes redundant
> register offset definition. Also corrects comment section at few places.
> 
> Changes since v1:
>  - Keeping back inclusion of header "platform_device.h" in exynos.c.
>  - Removing all unused instances of S3C_UART_OFFSET from mach-exynos,
>    mach-s3c24xx, and plat-samsung, in single patch.
>  - Patch 1/3 is already merged in maintainer tree so not included in v2. 

Thanks for the changes. I appreciate that!

Applied both patches.

Best regards,
Krzysztof

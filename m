From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 28 Jan 2017 17:52:24 +0200
Subject: [PATCH] ARM: dts: exynos: Increase MFC left reserved memory
 region size
In-Reply-To: <1485547846-12778-1-git-send-email-javier@osg.samsung.com>
References: <1485547846-12778-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20170128155224.wp6ykqex5sxt6ko7@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 05:10:46PM -0300, Javier Martinez Canillas wrote:
> The sizes of the MFC reserved memory regions for CMA are 16 MiB for the
> left bank and 8 MiB for the right bank. But this isn't enough to decode
> high resolution videos so increase the size for the left bank to 36 MiB
> which is enough for 1080p (1920x1080).
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks, applied.

Best regards,
Krzysztof

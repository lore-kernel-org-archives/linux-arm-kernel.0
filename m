From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 May 2017 18:17:04 +0100
Subject: [PATCH] [v2] MAINTAINERS: arm64 defconfig changes should go to
 arm@kernel.org
In-Reply-To: <1493830346-16406-1-git-send-email-timur@codeaurora.org>
References: <1493830346-16406-1-git-send-email-timur@codeaurora.org>
Message-ID: <20170503171704.GD23620@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 11:52:26AM -0500, Timur Tabi wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 58590cf..5d15858 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2066,6 +2066,11 @@ S:	Maintained
>  F:	arch/arm64/
>  F:	Documentation/arm64/
>  
> +ARM64 DEFCONFIG
> +M:	arm at kernel.org
> +S:	Maintained
> +F:	arch/arm64/configs/defconfig

You need an 'L' entry as well (linux-arm-kernel at lists.infradead.org).

-- 
Catalin

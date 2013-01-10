From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 10 Jan 2013 09:40:34 -0500
Subject: [PATCH 2/3] ARM: remove unused arch_decomp_wdog()
In-Reply-To: <1357827165-9320-3-git-send-email-shawn.guo@linaro.org>
References: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
 <1357827165-9320-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130110144034.GM5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 10:12:44PM +0800, Shawn Guo wrote:
> With ARCH_HAS_DECOMP_WDOG removed from arch/arm/boot/compressed/decompress.c,
> all the arch_decomp_wdog() definition at platform level is unneeded.
> Remmove it.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-dove/include/mach/uncompress.h       |    1 -
>  arch/arm/mach-kirkwood/include/mach/uncompress.h   |    1 -
>  arch/arm/mach-mv78xx0/include/mach/uncompress.h    |    1 -
>  arch/arm/mach-orion5x/include/mach/uncompress.h    |    1 -

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 7 Jul 2011 11:32:32 -0500
Subject: [PATCH 07/52] ARM: mach-ep93xx: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-7-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
	<1309920457-21913-7-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F383D6CED9@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 05, 2011 7:47 PM, Nicolas Pitre wrote:
>
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
>  arch/arm/mach-ep93xx/adssphere.c   |    2 +-
>  arch/arm/mach-ep93xx/edb93xx.c     |   16 ++++++++--------
>  arch/arm/mach-ep93xx/gesbc9312.c   |    2 +-
>  arch/arm/mach-ep93xx/micro9.c      |    8 ++++----
>  arch/arm/mach-ep93xx/simone.c      |    2 +-
>  arch/arm/mach-ep93xx/snappercl15.c |    2 +-
>  arch/arm/mach-ep93xx/ts72xx.c      |    2 +-
>  7 files changed, 17 insertions(+), 17 deletions(-)

For ep93xx, this appears to be dependant on your patch:

[PATCH 10/37] ARM: mach-ep93xx: remove mach/memory.h and Kconfig selection of SDRAM bank

Please make sure that the merge order of these patches does not
break anything...

Other than that, for the ep93xx part.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

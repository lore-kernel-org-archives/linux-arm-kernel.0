From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 20 Apr 2018 13:26:46 +0200 (CEST)
Subject: [PATCH 9/9] arm64: dts: broadcom: Add reference to Raspberry Pi
 3 B+
In-Reply-To: <1523640478-4448-10-git-send-email-stefan.wahren@i2se.com>
References: <1523640478-4448-1-git-send-email-stefan.wahren@i2se.com>
 <1523640478-4448-10-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1023874068.10388.1524223606275@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,
hi Will,

> Stefan Wahren <stefan.wahren@i2se.com> hat am 13. April 2018 um 19:27 geschrieben:
> 
> 
> This adds a reference to the dts of the Raspberry Pi 3 B+
> in arm, so don't need to maintain the content in arm64.

are you okay with the arm64 parts of this series?

> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm64/boot/dts/broadcom/Makefile                 | 3 ++-
>  arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts
> 
> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
> index 2a2591e..1193a9e 100644
> --- a/arch/arm64/boot/dts/broadcom/Makefile
> +++ b/arch/arm64/boot/dts/broadcom/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
> -dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb
> +dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb \
> +			      bcm2837-rpi-3-b-plus.dtb
>  
>  subdir-y	+= northstar2
>  subdir-y	+= stingray
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts
> new file mode 100644
> index 0000000..46ad202
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "arm/bcm2837-rpi-3-b-plus.dts"
> -- 
> 2.7.4
>

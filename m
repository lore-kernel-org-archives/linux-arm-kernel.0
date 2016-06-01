From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Jun 2016 00:00:25 +0200
Subject: [PATCH 09/32] bcm2837-rpi-3-b.dts for 32bit arm
In-Reply-To: <1464817421-8519-10-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-10-git-send-email-kraxel@redhat.com>
Message-ID: <7065434.SNfT8zjcK3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 1, 2016 11:43:18 PM CEST Gerd Hoffmann wrote:
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> new file mode 100644
> index 0000000..36178a6
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> @@ -0,0 +1 @@
> +#include "../../../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts"
> -- 
> 1.8.3.1
> 

What does this gain you?

	Arnd

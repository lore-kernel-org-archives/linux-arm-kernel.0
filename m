From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 7 Jun 2016 20:06:13 +0200
Subject: [PATCH v3 1/2] ARM: at91/dt: at91sam9260: Remove leading zeros
 in OHCI node.
In-Reply-To: <1464934539-4737-1-git-send-email-raashidmuhammed@zilogic.com>
References: <1464934539-4737-1-git-send-email-raashidmuhammed@zilogic.com>
Message-ID: <20160607180613.GO3363@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2016 at 11:45:38 +0530, Raashid Muhammed wrote :
> From: Raashid Muhammed <raashidmuhammed@zilogic.com>
> 
> Remove leading zeros in OHCI node for at91sam9260 based boards.
> 
> Signed-off-by: Raashid Muhammed <raashidmuhammed@zilogic.com>
> Reviewed-by: Vijay Kumar B. <vijaykumar@bravegnu.org>
> ---
>  arch/arm/boot/dts/aks-cdu.dts               | 2 +-
>  arch/arm/boot/dts/animeo_ip.dts             | 2 +-
>  arch/arm/boot/dts/at91-foxg20.dts           | 2 +-
>  arch/arm/boot/dts/at91-kizbox.dts           | 2 +-
>  arch/arm/boot/dts/at91-qil_a9260.dts        | 2 +-
>  arch/arm/boot/dts/at91sam9260.dtsi          | 2 +-
>  arch/arm/boot/dts/at91sam9g20ek_common.dtsi | 2 +-
>  arch/arm/boot/dts/ethernut5.dts             | 2 +-
>  arch/arm/boot/dts/evk-pro3.dts              | 2 +-
>  arch/arm/boot/dts/usb_a9260_common.dtsi     | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

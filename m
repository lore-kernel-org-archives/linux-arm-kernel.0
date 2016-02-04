From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 4 Feb 2016 23:58:59 +0100
Subject: [PATCH 03/11] drivers: rtc: allow compilation of sun6i RTC for
 all sunxi SoCs
In-Reply-To: <1454348370-3816-4-git-send-email-andre.przywara@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-4-git-send-email-andre.przywara@arm.com>
Message-ID: <20160204225859.GF4782@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2016 at 17:39:22 +0000, Andre Przywara wrote :
> At the moment the "sun6i" RTC drivers depends on having two specific
> SoC families selected.
> The Allwinner A64 SoC has the same RTC, so extend the Kconfig option
> to allow inclusion of the driver for all Allwinner SoCs.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/rtc/Kconfig | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sun, 28 Jun 2015 19:48:31 +0200
Subject: [PATCH] ARM: BCM5301X: Enable UART0 on tested devices
In-Reply-To: <1435513590-32139-1-git-send-email-zajec5@gmail.com>
References: <1435103504-28592-1-git-send-email-f.fainelli@gmail.com>
 <1435513590-32139-1-git-send-email-zajec5@gmail.com>
Message-ID: <5590336F.5040602@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2015 07:46 PM, Rafa? Mi?ecki wrote:
> There are two possible UARTs so we have (both of) them disabled by
> default. Override uart0 status on devices that were verified to use it.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  | 4 ++++
>  arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       | 4 ++++
>  arch/arm/boot/dts/bcm4708-netgear-r6250.dts        | 4 ++++
>  arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      | 4 ++++
>  arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 4 ++++
>  5 files changed, 20 insertions(+)
> 

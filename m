From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 26 Apr 2016 11:37:06 -0400
Subject: [PATCH 7/7] ARM: dts: lpc32xx: phy3250: add SoC name prefix to
 board dts file
In-Reply-To: <1461631050-10479-8-git-send-email-vz@mleia.com>
References: <1461631050-10479-1-git-send-email-vz@mleia.com>
 <1461631050-10479-8-git-send-email-vz@mleia.com>
Message-ID: <1461685026.9433.5.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-04-26 at 03:37 +0300, Vladimir Zapolskiy wrote:
> To simplify matching of DTS files of all NXP LPC32xx powered boards by
> a file name add 'lpc3250' prefix to PHYTEC PHYCORE-LPC3250 board dts
> file.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  arch/arm/boot/dts/Makefile                             | 2 +-
>  arch/arm/boot/dts/{phy3250.dts => lpc3250-phy3250.dts} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename arch/arm/boot/dts/{phy3250.dts => lpc3250-phy3250.dts} (100%)
> 
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

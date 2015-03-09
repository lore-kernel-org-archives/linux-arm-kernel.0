From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Mar 2015 22:21:08 +0100
Subject: [PATCH v2 3/3] ARM: mx25: Remove platform code support files
In-Reply-To: <1425662758-4675-3-git-send-email-festevam@gmail.com>
References: <1425662758-4675-1-git-send-email-festevam@gmail.com>
 <1425662758-4675-3-git-send-email-festevam@gmail.com>
Message-ID: <21909740.nfZYRJLb3G@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 March 2015 14:25:58 Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> As mx25 is a dt-only platform, we can get rid of platform code support files, 
> which are unused now.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - None
> 
>  arch/arm/mach-imx/Makefile        |   2 +-
>  arch/arm/mach-imx/devices-imx25.h |  85 -------
>  arch/arm/mach-imx/ehci-imx25.c    |  99 -------
>  arch/arm/mach-imx/iomux-mx25.h    | 524 --------------------------------------
> 

Very nice, good to see some progress on the old machines!

If you find the time, could you summarize your plans for the remaining
i.MX SoCs that have board files (imx21, imx27, imx31, imx35)? Do you plan
to continue with those, one by one?

	Arnd

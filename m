From: julien.boibessot@free.fr (Julien Boibessot)
Date: Thu, 13 Oct 2011 18:10:10 +0200
Subject: [PATCH 2/2] arm/mx5: add device tree support for imx51 babbage
In-Reply-To: <1317389747-24589-3-git-send-email-shawn.guo@linaro.org>
References: <1317389747-24589-1-git-send-email-shawn.guo@linaro.org>
	<1317389747-24589-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <4E970D62.9090403@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/2011 15:35, Shawn Guo wrote:
> It adds device tree support for imx51 babbage board.
>
cut
> diff --git a/arch/arm/mach-mx5/imx51-dt.c b/arch/arm/mach-mx5/imx51-dt.c
> new file mode 100644
> index 0000000..0878441
> --- /dev/null
> +++ b/arch/arm/mach-mx5/imx51-dt.c
> @@ -0,0 +1,116 @@
cut
> +
> +static void __init imx51_timer_init(void)
> +{
> +	mx51_clocks_init(32768, 24000000, 22579200, 0);
> +}

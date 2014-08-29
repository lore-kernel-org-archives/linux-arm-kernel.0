From: horms@verge.net.au (Simon Horman)
Date: Fri, 29 Aug 2014 09:32:04 +0900
Subject: [PATCH] ARM: dts: Sort SHMOBILE dtbs alphabetically
In-Reply-To: <1409227243-25102-1-git-send-email-geert+renesas@glider.be>
References: <1409227243-25102-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20140829003204.GA22661@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 02:00:43PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends on Magnus' series "[PATCH 00/05] ARM: shmobile: r8a7740 and
> Armadillo cleanup".

As per my response to that series:

   Thanks. I have tentatively queued this up.

   I got some push back from Olof [CCed] about putting cleanups on top of
   development when sending pull-requests for v3.17. This series falls
   into the same category: cleaning up board and related files on top
   of changes to initialise devices using DT.

   Olof, ideally I'd like this to go into v3.18.
   Let me know if you have preference to delay it.

>  arch/arm/boot/dts/Makefile | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 2bff594ca7e2..8f9604c6ca24 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -358,24 +358,24 @@ dtb-$(CONFIG_ARCH_S5PV210) += s5pv210-aquila.dtb \
>  	s5pv210-smdkv210.dtb \
>  	s5pv210-torbreck.dtb
>  dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += r7s72100-genmai.dtb \
> +	r8a73a4-ape6evm.dtb \
> +	r8a73a4-ape6evm-reference.dtb \
>  	r8a7740-armadillo800eva.dtb \
>  	r8a7778-bockw.dtb \
>  	r8a7778-bockw-reference.dtb \
>  	r8a7779-marzen.dtb \
> -	r8a7791-koelsch.dtb \
>  	r8a7790-lager.dtb \
> +	r8a7791-koelsch.dtb \
> +	sh7372-mackerel.dtb \
>  	sh73a0-kzm9g.dtb \
> -	sh73a0-kzm9g-reference.dtb \
> -	r8a73a4-ape6evm.dtb \
> -	r8a73a4-ape6evm-reference.dtb \
> -	sh7372-mackerel.dtb
> +	sh73a0-kzm9g-reference.dtb
>  dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
>  	r7s72100-genmai.dtb \
>  	r8a7740-armadillo800eva.dtb \
> -	r8a7791-henninger.dtb \
> -	r8a7791-koelsch.dtb \
> +	r8a7779-marzen.dtb \
>  	r8a7790-lager.dtb \
> -	r8a7779-marzen.dtb
> +	r8a7791-henninger.dtb \
> +	r8a7791-koelsch.dtb
>  dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
>  	socfpga_cyclone5_socdk.dtb \
>  	socfpga_cyclone5_sockit.dtb \
> -- 
> 1.9.1
> 

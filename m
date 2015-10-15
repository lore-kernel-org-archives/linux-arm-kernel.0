From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 Oct 2015 08:34:32 +0200
Subject: [PATCH] ARM: mvebu: correct a385-db-ap compatible string
In-Reply-To: <1444871828-1080-1-git-send-email-mw@semihalf.com> (Marcin
 Wojtas's message of "Thu, 15 Oct 2015 03:17:08 +0200")
References: <1444871828-1080-1-git-send-email-mw@semihalf.com>
Message-ID: <87r3kw3aiv.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,
 
 On jeu., oct. 15 2015, Marcin Wojtas <mw@semihalf.com> wrote:

> This commit enables standby support on Armada 385 DB-AP board, because the PM
> initalization routine requires "marvell,armada380" compatible string for all
> Armada 38x-based platforms.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

Applied on mvebu/fixes.
I also aded the commit it fixes, add the stabel team in CC and also
mention in the commit log that the compatible "marvell,armada38x" was
wrong.

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/armada-385-db-ap.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
> index 89f5a95..4047621 100644
> --- a/arch/arm/boot/dts/armada-385-db-ap.dts
> +++ b/arch/arm/boot/dts/armada-385-db-ap.dts
> @@ -46,7 +46,7 @@
>  
>  / {
>  	model = "Marvell Armada 385 Access Point Development Board";
> -	compatible = "marvell,a385-db-ap", "marvell,armada385", "marvell,armada38x";
> +	compatible = "marvell,a385-db-ap", "marvell,armada385", "marvell,armada380";
>  
>  	chosen {
>  		stdout-path = "serial1:115200n8";
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

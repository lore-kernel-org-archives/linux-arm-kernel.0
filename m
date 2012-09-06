From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Sep 2012 13:18:18 -0700
Subject: [PATCH v2 2/8] ARM/dts: omap2420-h4: Include omap2420.dtsi
 file instead the common omap2
In-Reply-To: <1346247067-9632-3-git-send-email-peter.ujfalusi@ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
 <1346247067-9632-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120906201818.GG1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120829 06:31]:
> Since the board is based on OMAP2420 we should include the dedicated dtsi
> file (which includes the common omap2 dtsi).
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/boot/dts/omap2420-h4.dts |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
> index 25b50b7..77b84e1 100644
> --- a/arch/arm/boot/dts/omap2420-h4.dts
> +++ b/arch/arm/boot/dts/omap2420-h4.dts
> @@ -7,7 +7,7 @@
>   */
>  /dts-v1/;
>  
> -/include/ "omap2.dtsi"
> +/include/ "omap2420.dtsi"
>  
>  / {
>  	model = "TI OMAP2420 H4 board";

Oops looks like I have this too in one of my patches. I'll drop
that part in my patches.

Tony

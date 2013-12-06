From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 07 Dec 2013 00:31:50 +0100
Subject: [PATCH] ARM: dts: mxs: add #io-channel-cells to mx28 lradc
In-Reply-To: <1386361231-20427-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1386361231-20427-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <52A25E66.6040403@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit message should have been:

Adding #io-channel-cells property to lradc allows us to use the lradc as
an iio provider.

On 06/12/2013 21:20, Alexandre Belloni wrote:
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/imx28.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index cda19c8b0a47..92d9f9e33bf1 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -945,6 +945,7 @@
>  						20 21 22 23 24 25>;
>  				status = "disabled";
>  				clocks = <&clks 41>;
> +				#io-channel-cells = <1>;
>  			};
>  
>  			spdif: spdif at 80054000 {


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

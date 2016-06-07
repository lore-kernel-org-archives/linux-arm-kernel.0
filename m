From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 7 Jun 2016 09:31:38 +0300
Subject: [PATCH] ARM: dts: DRA74x: fix DSS PLL2 addresses
In-Reply-To: <1463739213-31540-1-git-send-email-tomi.valkeinen@ti.com>
References: <1463739213-31540-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <57566A4A.4020102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 20/05/16 13:13, Tomi Valkeinen wrote:
> DSS's 'pll2_clkctrl' and 'pll2' have wrong addresses in the dra74x.dtsi
> file. Video PLL2 has not been used so wrong addresses went unnoticed.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/boot/dts/dra74x.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
> index 4220eeffc65a..5e06020f450b 100644
> --- a/arch/arm/boot/dts/dra74x.dtsi
> +++ b/arch/arm/boot/dts/dra74x.dtsi
> @@ -107,8 +107,8 @@
>  	reg = <0x58000000 0x80>,
>  	      <0x58004054 0x4>,
>  	      <0x58004300 0x20>,
> -	      <0x58005054 0x4>,
> -	      <0x58005300 0x20>;
> +	      <0x58009054 0x4>,
> +	      <0x58009300 0x20>;
>  	reg-names = "dss", "pll1_clkctrl", "pll1",
>  		    "pll2_clkctrl", "pll2";
>  
> 

Ping on this.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/401dfa30/attachment-0001.sig>

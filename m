From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Tue, 18 Jun 2013 16:14:15 -0400
Subject: [PATCHv3 3/6] arm: dts: add bandgap entry for OMAP443x devices
In-Reply-To: <1370637968-23299-4-git-send-email-eduardo.valentin@ti.com>
References: <1370637968-23299-1-git-send-email-eduardo.valentin@ti.com>
 <1370637968-23299-4-git-send-email-eduardo.valentin@ti.com>
Message-ID: <51C0BF97.6060900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit,

On 07-06-2013 16:46, Eduardo Valentin wrote:
> This patch add the bandgap entry for OMAP4430 devices.
> 
> Cc: "Beno?t Cousson" <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-omap at vger.kernel.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

Could you please have a look on this one?

> ---
>  arch/arm/boot/dts/omap443x.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
> index cccf39a..8d6c968 100644
> --- a/arch/arm/boot/dts/omap443x.dtsi
> +++ b/arch/arm/boot/dts/omap443x.dtsi
> @@ -24,4 +24,8 @@
>  			clock-latency = <300000>; /* From legacy driver */
>  		};
>  	};
> +	bandgap {
> +		reg = <0x4a002260 0x4 0x4a00232C 0x4>;
> +		compatible = "ti,omap4430-bandgap";
> +	};
>  };
> 


-- 
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/f3e2a54f/attachment.sig>

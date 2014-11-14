From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Nov 2014 16:06:15 +0100
Subject: [PATCH V2 4/7] arm64: dts: Add Designware GPIO dts binding to APM
 X-Gene platform
In-Reply-To: <1415924401-3013-5-git-send-email-fkan@apm.com>
References: <1415924401-3013-1-git-send-email-fkan@apm.com>
 <1415924401-3013-5-git-send-email-fkan@apm.com>
Message-ID: <1829495.FoDfH1G36W@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 November 2014 16:19:58 Feng Kan wrote:
> +               dwgpio: dwgpio at 1c024000 {
> +                       compatible = "snps,dw-apb-gpio";
> +                       reg = <0x0 0x1c024000 0x0 0x1000>;
> +                       reg-io-width = <4>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> 

Same comment as patch 1: make the node name 'gpio', not 'dwgpio'.

	Arnd

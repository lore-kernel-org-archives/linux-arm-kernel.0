From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Sat, 3 Aug 2013 17:19:52 +0530
Subject: [PATCH 2/2] ARM: dts: AM4372: add few nodes
In-Reply-To: <6f0f838176ab93aac8dab4c3ab9d9f95a3027ff7.1375450395.git.afzal@ti.com>
References: <ffa2f76fcac54bfe76c234ffce0394fd2c25fe52.1375450395.git.afzal@ti.com>
 <6f0f838176ab93aac8dab4c3ab9d9f95a3027ff7.1375450395.git.afzal@ti.com>
Message-ID: <51FCEE60.7080809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/2/2013 7:16 PM, Afzal Mohammed wrote:
> +		mac: ethernet at 4a100000 {
> +			compatible = "ti,am4372-cpsw","ti,cpsw";
compatibility "ti,am4372-cpsw" is not needed as driver has only "ti,cpsw"
compatibility
> +			reg = <0x4a100000 0x800
> +			       0x4a101200 0x100>;
> +			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +			ti,hwmods = "cpgmac0";
> +			status = "disabled";
> +		};
There are many other parameters which are missed here.

Regards
Mugunthan V N

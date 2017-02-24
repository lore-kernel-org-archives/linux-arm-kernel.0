From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sat, 25 Feb 2017 00:36:56 +0100
Subject: [PATCH v2 10/17] ARM: dts: Add Actions Semi S500 and LeMaker
 Guitar
In-Reply-To: <20170224034055.18807-11-afaerber@suse.de>
References: <20170224034055.18807-1-afaerber@suse.de>
 <20170224034055.18807-11-afaerber@suse.de>
Message-ID: <ffe879b7-e69b-c07e-f165-0270609083f9@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.02.2017 um 04:40 schrieb Andreas F?rber:
> +		uart2: serial at b0124000 {
> +			compatible = "actions,s500-uart", "actions,owl-uart";
> +			reg = <0xb0126000 0x2000>;

Wrong reg offset.

> +			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		uart3: serial at b0126000 {
> +			compatible = "actions,s500-uart", "actions,owl-uart";
> +			reg = <0xb0126000 0x2000>;
> +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)

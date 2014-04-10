From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 10 Apr 2014 11:25:07 +0100
Subject: [PATCH v2 08/12] ARM: dts: add hip04-d01 dts file
In-Reply-To: <1396944052-9887-9-git-send-email-haojian.zhuang@linaro.org>
References: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
 <1396944052-9887-9-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140410102507.GB5499@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 04:00:48PM +0800, Haojian Zhuang wrote:
> Add hip04.dtsi & hip04-d01.dts file to support HiP04 SoC platform.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

[...]

> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> index df0a452..47c0a13 100644
> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt

[...]

> @@ -31,6 +35,14 @@ Example:
>  		reboot-offset = <0x4>;
>  	};
>  
> +
> +Hisilicon MCPM Implementation
> +
> +Required Properties:
> +- compatible: "hisilicon,hip04-mcpm"
> +- reg: Register address and size.
> +
> +

Unless you have a component in your hardware called "MCPM", this is
describing a power controller peripheral.  If so, what is it?

Cheers
---Dave

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 09 Sep 2013 15:11:43 -0600
Subject: [PATCH 3/3] arm: dts: socfpga: Add support for SD/MMC
In-Reply-To: <1378740833-4883-4-git-send-email-dinguyen@altera.com>
References: <1378740833-4883-1-git-send-email-dinguyen@altera.com>
 <1378740833-4883-4-git-send-email-dinguyen@altera.com>
Message-ID: <522E398F.3080100@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2013 09:33 AM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add bindings for SD/MMC for SOCFPGA.

> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

> +* Altera SOCFPGA specific extensions to the Synopsis Designware Mobile
> +  Storage Host Controller
> +
> +The Synopsis designware mobile storage host controller is used to interface
> +a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> +differences between the core Synopsis dw mshc controller properties described
> +by synopsis-dw-mshc.txt and the properties used by the SOCFPGA specific
> +extensions to the Synopsis Designware Mobile Storage Host Controller.
> +
> +Required Properties:
> +
> +* compatible: should be
> +        - "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
> +          specific extensions.
> +
> +* samsung,dw-mshc-sdr-timing: See exynos-dw-mshc.txt for more information about
> +	this binding.

s/binding/property/

It's odd that this isn't "synopsis," rather than "samsung," if the
property is generic across all/some uses of the Synopsis core. But, I
guess this is fine.

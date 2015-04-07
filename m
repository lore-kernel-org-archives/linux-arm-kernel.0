From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 7 Apr 2015 21:45:01 +0200
Subject: [PATCH] ARM: at91/dt: add support for kizbox2.
In-Reply-To: <1428416031-30765-2-git-send-email-g.portay@overkiz.com>
References: <1428416031-30765-1-git-send-email-g.portay@overkiz.com>
 <1428416031-30765-2-git-send-email-g.portay@overkiz.com>
Message-ID: <20150407214501.3189230a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  7 Apr 2015 16:13:51 +0200
Ga?l PORTAY <g.portay@overkiz.com> wrote:

> Add DT file for Kizbox 2 board.
> This board is based on Atmel's SAMA5D31 Cortex-A5 SoC.
> 
> Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
> ---
>  arch/arm/boot/dts/Makefile         |   1 +
>  arch/arm/boot/dts/at91-kizbox2.dts | 223 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 224 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-kizbox2.dts
> 

[...]

> +/dts-v1/;
> +#include "sama5d31.dtsi"
> +#include "sama5d3_emac.dtsi"
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	model = "Overkiz Kizbox 2";
> +	compatible = "overkiz,kizbox2", "atmel,sama5d31ek", "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";

Oh, and as Alexandre noticed in your other patch series, you should
just define:

	compatible = "overkiz,kizbox2", "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";





-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 23 Feb 2015 15:54:49 +0100
Subject: [PATCH 4/8] ARM: dts: dove: Always include gpio and
 interrupt-controller headers
In-Reply-To: <1424199129-22099-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1424199129-22099-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <54EB3F39.6030304@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On 17/02/2015 19:52, Sebastian Hesselbarth wrote:
> We want to enforce the use of named flags in GPIO and interrupt
> specifiers, include the corresponding headers to Dove's SoC dtsi.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> ---
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Gabriel Dobato <dobatog@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/dove.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 3cc8b8320345..cae865435762 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -1,5 +1,8 @@
>  /include/ "skeleton.dtsi"
>  
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
>  #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
>  
>  / {
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

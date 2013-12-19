From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Dec 2013 17:47:40 +0100
Subject: [PATCH 0/3] ARM: at91/dt: add clock properties to sama5d3 crypto
 devs
In-Reply-To: <1387465875-4548-1-git-send-email-b.brezillon@overkiz.com>
References: <1387465875-4548-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <52B3232C.3000400@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/12/2013 16:11, Boris BREZILLON :
> Hello,
> 
> This series adds missing clock properties in sama5d3 crypto devices nodes.

Fine, thanks Boris. On the whole series:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

and integrated in the at91-3.14-dt2 branch.

Bye,

> Best Regards,
> 
> Boris
> 
> Boris BREZILLON (3):
>   ARM: at91/dt: add clk properties to sama5d3 SHA device node
>   ARM: at91/dt: add clk properties to sama5d3 AES device node
>   ARM: at91/dt: add clk properties to sama5d3 TDES device node
> 
>  arch/arm/boot/dts/sama5d3.dtsi |    6 ++++++
>  1 file changed, 6 insertions(+)
> 


-- 
Nicolas Ferre

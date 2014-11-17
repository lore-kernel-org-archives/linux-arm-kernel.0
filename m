From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 17 Nov 2014 21:26:25 +0300
Subject: [PATCH v8 10/13] ARM: dts: berlin: add BG2Q nodes for USB support
In-Reply-To: <1416231347-27193-11-git-send-email-antoine.tenart@free-electrons.com>
References: <1416231347-27193-1-git-send-email-antoine.tenart@free-electrons.com>
 <1416231347-27193-11-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <546A3DD1.8020209@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/17/2014 04:35 PM, Antoine Tenart wrote:

> Adds nodes describing the Marvell Berlin BG2Q USB PHY and USB. The BG2Q
> SoC has 3 USB host controller, compatible with ChipIdea.

> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 55 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)

> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 2de8d6f8973c..834142bdfbb1 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
[...]
> @@ -457,5 +511,6 @@
>   				interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
>   			};
>   		};
> +

    Random whitespace change?

>   	};
>   };
>

WBR, Sergei

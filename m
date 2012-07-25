From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 25 Jul 2012 15:20:56 +0400
Subject: [PATCH v2 6/6] arm/dts: am33xx rtc node
In-Reply-To: <d16976055462214af276d7242faa2bc6e621fd44.1343191280.git.afzal@ti.com>
References: <cover.1343191280.git.afzal@ti.com>
 <d16976055462214af276d7242faa2bc6e621fd44.1343191280.git.afzal@ti.com>
Message-ID: <500FD698.30906@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 25-07-2012 10:12, Afzal Mohammed wrote:

> Add AM33xx rtc node.

> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---

> v2:
>   Use compatible as ti,da830-rtc instead of ti,am1808-rtc

>   arch/arm/boot/dts/am33xx.dtsi |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index bd0cff3..e1ed72d 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -159,5 +159,10 @@
>   			compatible = "ti,omap3-wdt";
>   			ti,hwmods = "wd_timer2";
>   		};
> +
> +		rtc at 44e3e000 {

    Address postfix in the node name without "reg" property?

> +			compatible = "ti,da830-rtc";
> +			ti,hwmods = "rtc";
> +		};

WBR, Sergei

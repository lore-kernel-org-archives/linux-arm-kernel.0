From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 30 Oct 2014 14:33:04 +0300
Subject: [PATCH/RFC] ARM: shmobile: lager: Fix node name of GPIO keys
In-Reply-To: <1414648571-30419-1-git-send-email-horms+renesas@verge.net.au>
References: <1414648571-30419-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <545221F0.2030509@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/30/2014 8:56 AM, Simon Horman wrote:

> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

> gpio_keys appears to be consistent with more dts files than gpio-keys

    Vice versa, I guess if you're changing underscore to hyphen?

> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> [simon: reworded changelog]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree

>   arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 830f2e8..6c05644 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -43,7 +43,7 @@
>   		#size-cells = <1>;
>   	};
>
> -	gpio_keys {
> +	gpio-keys {
>   		compatible = "gpio-keys";

WBR, Sergei

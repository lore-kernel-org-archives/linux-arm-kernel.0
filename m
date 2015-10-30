From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 30 Oct 2015 13:43:58 +0300
Subject: [PATCH v5 07/14] arm64: renesas: salvator-x: Sound SSI PIO support
In-Reply-To: <1446161280-23097-8-git-send-email-horms+renesas@verge.net.au>
References: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
 <1446161280-23097-8-git-send-email-horms+renesas@verge.net.au>
Message-ID: <563349EE.8000606@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/30/2015 2:27 AM, Simon Horman wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> This patch adds PIO sound support for Salvator-X board.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 95 ++++++++++++++++++++++
>   1 file changed, 95 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> index 0599b2be90ab..6a7df7e0ef7a 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
[...]
> @@ -71,4 +103,67 @@
>   	pinctrl-names = "default";
>
>   	status = "okay";
> +
> +	clock-frequency = <100000>;
> +
> +	ak4613: codec at 0x10 {

    Please drop "0x" from the node name.

[...]

MBR, Sergei

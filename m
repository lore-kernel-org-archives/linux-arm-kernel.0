From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 28 Jul 2015 16:48:57 +0300
Subject: [PATCH 3/4] ARM: dts: rockchip: Add SPDIF transceiver for RK3188
In-Reply-To: <1438085011-16577-4-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1438085011-16577-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1438085011-16577-4-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <55B78849.6060706@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 7/28/2015 3:03 PM, Sjoerd Simons wrote:

> Add the SPDIF transceiver controller and pin for RK3188

> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> ---
>   arch/arm/boot/dts/rk3188.dtsi | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)

> diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
> index 0f23aed..43e9bdf 100644
> --- a/arch/arm/boot/dts/rk3188.dtsi
> +++ b/arch/arm/boot/dts/rk3188.dtsi
> @@ -121,6 +121,22 @@
>   		status = "disabled";
>   	};
>
> +	spdif: spdif at 0x1011e000 {

    Please drop "0x". And I'd call the node "sound at ..." to match the ePAPR 
standard.

[...]

MBR, Sergei

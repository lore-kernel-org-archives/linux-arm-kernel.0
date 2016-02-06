From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 6 Feb 2016 15:49:15 +0300
Subject: [PATCH 4/5] ARM: dts: NSP: Add SP805 Support to DT
In-Reply-To: <1454712204-30419-5-git-send-email-jonmason@broadcom.com>
References: <1454712204-30419-1-git-send-email-jonmason@broadcom.com>
 <1454712204-30419-5-git-send-email-jonmason@broadcom.com>
Message-ID: <56B5EBCB.4080305@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 2/6/2016 1:43 AM, Jon Mason wrote:

> Add support for the ARM SP805 Watchdog timer to the Northstar Plus
> device tree.
>
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---
>   arch/arm/boot/dts/bcm-nsp.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
> index 415a0a6..0e8cb6e 100644
> --- a/arch/arm/boot/dts/bcm-nsp.dtsi
> +++ b/arch/arm/boot/dts/bcm-nsp.dtsi
> @@ -203,6 +203,14 @@
>   			clock-frequency = <100000>;
>   		};
>
> +		wdt at 39000 {

    Should be "watchdog at 39000", according to ePAPR.

[...]

MBR, Sergei

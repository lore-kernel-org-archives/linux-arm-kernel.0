From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 23 Apr 2014 13:22:53 +0200
Subject: [PATCH v2 16/38] ARM: orion5x: add linux, stdout-path to edmini_v2
In-Reply-To: <1398202002-28530-17-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-17-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5357A28D.2010207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 11:26 PM, Thomas Petazzoni wrote:
> This commit adds the new linux,stdout-path to the edmini_v2 platform,
> pointing to the serial device use for the console.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> index d85a206..df53d256 100644
> --- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> +++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> @@ -22,6 +22,7 @@
>
>   	chosen {
>   		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +		linux,stdout-path = &uart0;
>   	};
>
>   	soc {
>

From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 27 Jan 2015 23:06:07 -0300
Subject: [PATCH v2 2/2] ARM: mvebu: a385-db-ap: Enable the NAND
In-Reply-To: <1422284164-16867-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1422284164-16867-1-git-send-email-maxime.ripard@free-electrons.com>
 <1422284164-16867-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <54C8440F.3090906@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/26/2015 11:56 AM, Maxime Ripard wrote:
> The Armada 385 Access Point Development Board has a 1GB NAND SLC chip from
> Micron as its main storage. Enable it.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-385-db-ap.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
> index b891b4c897f5..ee648fb19075 100644
> --- a/arch/arm/boot/dts/armada-385-db-ap.dts
> +++ b/arch/arm/boot/dts/armada-385-db-ap.dts
> @@ -130,6 +130,19 @@
>  				phy-mode = "rgmii-id";
>  			};
>  
> +			nfc: flash at d0000 {

I don't think you need to have this phandle here.

In any case, for both patches:

Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

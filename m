From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 13 Apr 2013 12:30:57 +0200
Subject: [PATCHv2 04/10] arm: kirkwood: add SoC-level Device Tree data
 for PCIe interfaces
In-Reply-To: <1365632436-25367-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365632436-25367-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1365632436-25367-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130413103057.GG2824@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 12:20:30AM +0200, Thomas Petazzoni wrote:
> This commit adds Device Tree details to enable the PCIe interfaces on
> Kirkwood. The 6281 has one PCIe interface, the 6282 has two PCIe
> interfaces.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/kirkwood-6281.dtsi |   31 ++++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-6282.dtsi |   48 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood.dtsi      |    1 +
>  3 files changed, 80 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kirkwood-6281.dtsi
> index d6c9d65..5137668 100644
> --- a/arch/arm/boot/dts/kirkwood-6281.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
> @@ -40,5 +40,36 @@
>  				marvell,function = "sdio";
>  			};
>  		};
> +
> +		pcie-controller {

Hi Thomas

Convention seems to be to use _ not - in these names.

	   Andrew

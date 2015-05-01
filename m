From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 1 May 2015 22:24:14 +0200
Subject: [PATCH 4/4] ARM: dts: sunxi: Add SPI aliases on A10s Olinuxino.
In-Reply-To: <b37eb9810d805ec1ac6e1e3f9d860c081ed87966.1430295711.git.hramrach@gmail.com>
References: <cover.1430295711.git.hramrach@gmail.com>
 <b37eb9810d805ec1ac6e1e3f9d860c081ed87966.1430295711.git.hramrach@gmail.com>
Message-ID: <20150501202414.GL6062@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 09:41:17AM +0200, Michal Suchanek wrote:
> SPI aliases give nicer spidev device node names.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
>  arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> index cd8d08a..a49fc6a 100644
> --- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> @@ -63,6 +63,9 @@
>  		serial0 = &uart0;
>  		serial1 = &uart2;
>  		serial2 = &uart3;
> +		spi0 = &spi0;
> +		spi1 = &spi1;
> +		spi2 = &spi2;

That patch should be merged with the patch 3, and since there's only
spi2 in use on that board, it should be aliased to spi0.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150501/48a47c75/attachment-0001.sig>

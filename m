From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 11 Jun 2018 15:44:21 +0800
Subject: [PATCH 2/2] ARM: dts: am437x: make edt-ft5x06 a wakeup source
 for imx6 boards
In-Reply-To: <20180523083013.7570-2-daniel@zonque.org>
References: <20180523083013.7570-1-daniel@zonque.org>
 <20180523083013.7570-2-daniel@zonque.org>
Message-ID: <20180611074420.GF16091@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 10:30:13AM +0200, Daniel Mack wrote:
> The touchscreen driver no longer configures the device as wakeup source by
> default. A "wakeup-source" property is needed.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>

This is not an imx6 board, and I have to leave it to relevant platform
maintainer.  The patch subject should be fixed to drop 'imx6'.

Shawn

> ---
>  arch/arm/boot/dts/am437x-sk-evm.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
> index 4118802b7fea..f17ed89da06b 100644
> --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> @@ -537,6 +537,8 @@
>  
>  		touchscreen-size-x = <480>;
>  		touchscreen-size-y = <272>;
> +
> +		wakeup-source;
>  	};
>  
>  	tlv320aic3106: tlv320aic3106 at 1b {
> -- 
> 2.14.3
> 

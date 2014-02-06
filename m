From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Feb 2014 10:19:34 -0500
Subject: [PATCH 2/4] DT: Vendor prefixes: Add ricoh, ssi and synology
In-Reply-To: <1391634309-3123-3-git-send-email-andrew@lunn.ch>
References: <1391634309-3123-1-git-send-email-andrew@lunn.ch>
 <1391634309-3123-3-git-send-email-andrew@lunn.ch>
Message-ID: <20140206151934.GB8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


+ devicetree ML, DT maintainers.

On Wed, Feb 05, 2014 at 10:05:07PM +0100, Andrew Lunn wrote:
> The following patches make use of vendor names ricoh, ssi and
> synology.  Add them to the vendor prefix list.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 3f900cd51bf0..1629e8f33578 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -69,6 +69,7 @@ ralink	Mediatek/Ralink Technology Corp.
>  ramtron	Ramtron International
>  realtek Realtek Semiconductor Corp.
>  renesas	Renesas Electronics Corporation
> +ricoh	Richoh Co. Ltd.

s/Richoh/Ricoh/

other than that,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

>  rockchip	Fuzhou Rockchip Electronics Co., Ltd
>  samsung	Samsung Semiconductor
>  sbs	Smart Battery System
> @@ -76,11 +77,13 @@ schindler	Schindler
>  sil	Silicon Image
>  silabs	Silicon Laboratories
>  simtek
> +sii	Seiko Instruments, Inc.
>  sirf	SiRF Technology, Inc.
>  snps 	Synopsys, Inc.
>  st	STMicroelectronics
>  ste	ST-Ericsson
>  stericsson	ST-Ericsson
> +synology	Synology, Inc.
>  ti	Texas Instruments
>  tlm	Trusted Logic Mobility
>  toshiba	Toshiba Corporation
> -- 
> 1.7.10.4
> 

From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 06 Mar 2014 13:21:03 +0100
Subject: [RESEND Patch 1/2] DT: Vendor: Add prefixes used by Kirkwood
 devices
In-Reply-To: <1394054474-4310-2-git-send-email-andrew@lunn.ch> (Andrew Lunn's
 message of "Wed, 5 Mar 2014 22:21:13 +0100")
References: <1394054474-4310-1-git-send-email-andrew@lunn.ch>
 <1394054474-4310-2-git-send-email-andrew@lunn.ch>
Message-ID: <8738ivy0uo.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Andrew Lunn <andrew@lunn.ch> writes:

> Add a number of vendor prefixes by kirkwood devices. These are not all
> stock tickers, but have been in use for a while so changing would not
> be easy.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index c73b435f58f5..860c467374fe 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -20,2 +20,3 @@ bosch	Bosch Sensortec GmbH
>  brcm	Broadcom Corporation
> +buffalo	Buffalo, Inc.
>  capella	Capella Microsystems, Inc
> @@ -30,2 +31,3 @@ davicom	DAVICOM Semiconductor, Inc.
>  denx	Denx Software Engineering
> +dlink	D-Link Corporation
>  edt	Emerging Display Technologies
> @@ -35,2 +37,3 @@ epson	Seiko Epson Corp.
>  est	ESTeem Wireless Modems
> +excito	Excito
>  fsl	Freescale Semiconductor
> @@ -39,2 +42,3 @@ gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
>  gmt	Global Mixed-mode Technology, Inc.
> +globalscale	GlobalScale Technologies, Inc.
>  gumstix	Gumstix, Inc.
> @@ -45,2 +49,3 @@ ibm	International Business Machines (IBM)
>  idt	Integrated Device Technologies, Inc.
> +iom	Iomega Corporation
>  img	Imagination Technologies Ltd.
> @@ -49,2 +54,4 @@ isl	Intersil
>  karo	Ka-Ro electronics GmbH
> +keymile	Keymile GmbH
> +lacie	LaCie
>  lg	LG Corporation
> @@ -56,3 +63,5 @@ microchip	Microchip Technology Inc.
>  mosaixtech	Mosaix Technologies, Inc.
> +mpl	MPL AG
>  national	National Semiconductor
> +netgear	Netgear, Inc.

I do not have a strong opinion on it but I think I read on LAKML there
was some kind of rule to use ticker symbol for a given vendor if it
exists e.g. ntgr for netgear (like fsl for freescale, brcm for broadcom,
etc).

Cheers,

a+

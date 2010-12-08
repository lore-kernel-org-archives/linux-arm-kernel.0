From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Wed, 8 Dec 2010 08:25:19 +0100
Subject: [PATCH v2 08/15] ARM: mxs: Add iomux support
In-Reply-To: <1291739523-25077-7-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-7-git-send-email-shawn.guo@freescale.com>
Message-ID: <19711.13023.154958.539289@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> MXS-based SoCs implements iomux functions in block PINCTRL.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes for v2:
>  - Define iomux_cfg_t as u64
     ^^^^^^^^^^^^^^^^^^^^^^^^^
Really?

> +typedef struct pad_desc {
> +	unsigned bank:12;
> +	unsigned pin:20;
> +	unsigned muxsel:8;
> +	unsigned ma:12;
> +	unsigned vol:8;
> +	unsigned pull:4;
> +} iomux_cfg_t;
^^^^^^^^^^^^^^^^^


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

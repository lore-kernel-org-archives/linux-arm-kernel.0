From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Mar 2015 15:26:11 +0100
Subject: [PATCH v6 4/6] ARM: dts: Alpine platform binding documentation
In-Reply-To: <55017e25.+YC0O9kly8Rbiti6%tsahee@annapurnalabs.com>
References: <55017e25.+YC0O9kly8Rbiti6%tsahee@annapurnalabs.com>
Message-ID: <2208616.RnIMDj94Ld@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 March 2015 13:53:09 Tsahee Zidenberg wrote:
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index aeb5bb5..cb94a098 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -11,6 +11,8 @@ adapteva      Adapteva, Inc.
>  adh    AD Holdings Plc.
>  adi    Analog Devices, Inc.
>  aeroflexgaisler        Aeroflex Gaisler AB
> +ak     Asahi Kasei Corp.
> +al     Annapurna Labs
>  allwinner      Allwinner Technology Co., Ltd.
>  alphascale     AlphaScale Integrated Circuits Systems, Inc.
>  altr   Altera Corp.
> 

The Asahi Kasei entry seems to be the result of an incorrect rebase, I've
edited the patch to remove this.

	Arnd

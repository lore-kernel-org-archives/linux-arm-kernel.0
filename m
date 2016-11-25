From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 25 Nov 2016 17:15:24 +0100
Subject: [PATCH v5 1/2] devicetree: Add vendor prefix for CZ.NIC
In-Reply-To: <20161125142658.21690-2-uwe@kleine-koenig.org> ("Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Fri, 25 Nov 2016 15:26:57
 +0100")
References: <20161125142658.21690-1-uwe@kleine-koenig.org>
 <20161125142658.21690-2-uwe@kleine-koenig.org>
Message-ID: <87mvgnilib.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
 
 On ven., nov. 25 2016, Uwe Kleine-K?nig <uwe@kleine-koenig.org> wrote:

> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>

Applied on mvebu/dt and I added back the Acked-by from Rob Herring.

Thanks,

Gregory


> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index f0a48ea78659..ae9fce9fed03 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -67,6 +67,7 @@ creative	Creative Technology Ltd
>  crystalfontz	Crystalfontz America, Inc.
>  cubietech	Cubietech, Ltd.
>  cypress	Cypress Semiconductor Corporation
> +cznic	CZ.NIC, z.s.p.o.
>  dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
>  davicom	DAVICOM Semiconductor, Inc.
>  delta	Delta Electronics, Inc.
> -- 
> 2.10.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

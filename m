From: robherring2@gmail.com (Rob Herring)
Date: Wed, 2 Apr 2014 14:18:44 -0500
Subject: [PATCH 1/2] of: add vendor prefix for Toradex AG
In-Reply-To: <b94e331a33407686547145a632ff2eb14ca42c9e.1396456704.git.stefan@agner.ch>
References: <cover.1396456704.git.stefan@agner.ch>
 <b94e331a33407686547145a632ff2eb14ca42c9e.1396456704.git.stefan@agner.ch>
Message-ID: <CAL_JsqLQPAW0RkP5=UAEWkLHSL_3n-xX=xJukCcYWLKUBiZFmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 2, 2014 at 11:47 AM,  <stefan@agner.ch> wrote:
> From: Stefan Agner <stefan@agner.ch>
>
> Adds toradex to the list of DT vendor prefixes.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index e9d19e2..6a68eae 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -91,6 +91,7 @@ ti    Texas Instruments
>  tlm    Trusted Logic Mobility
>  toshiba        Toshiba Corporation
>  toumaz Toumaz
> +toradex        Toradex AG
>  v3     V3 Semiconductor
>  via    VIA Technologies, Inc.
>  voipac Voipac Technologies s.r.o.
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

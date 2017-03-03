From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 03 Mar 2017 10:57:25 -0800
Subject: [PATCH 1/2] devicetree: Add vendor prefix for Hwacom Systems Inc.
In-Reply-To: <20170222163131.14136-2-carlo@caione.org> (Carlo Caione's message
 of "Wed, 22 Feb 2017 17:31:30 +0100")
References: <20170222163131.14136-1-carlo@caione.org>
 <20170222163131.14136-2-carlo@caione.org>
Message-ID: <m2a8922noq.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Carlo Caione <carlo@caione.org> writes:

> From: Carlo Caione <carlo@endlessm.com>
>
> Hwacom Systems Inc. is a broadband system integrator and supplier of
> mobile, fixed and IP networks related services as well as
> multimedia application. Website: http://www.hwacom.com/
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to v4.12/dt64 after changing subject prefix to "dt-bindings:"

Kevin

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 16d3b5e..a1704a6 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -131,6 +131,7 @@ holt	Holt Integrated Circuits, Inc.
>  honeywell	Honeywell
>  hp	Hewlett Packard
>  holtek	Holtek Semiconductor, Inc.
> +hwacom	HwaCom Systems Inc.
>  i2se	I2SE GmbH
>  ibm	International Business Machines (IBM)
>  idt	Integrated Device Technologies, Inc.

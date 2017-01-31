From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 Jan 2017 10:56:22 +0100
Subject: [PATCH v2 1/2] dt-bindings: gpu: Add Mali Utgard bindings
In-Reply-To: <2a5e7d0a-e2ca-5cc7-5193-96be5bfe494b@baylibre.com>
References: <a4d90de597cfcfab5fddeeb538505774a980818b.1485180017.git-series.maxime.ripard@free-electrons.com>
 <20170127201913.jjhdw57jmxifqpxa@rob-hp-laptop>
 <20170130134824.u37svxphyy266tzz@lukather>
 <2a5e7d0a-e2ca-5cc7-5193-96be5bfe494b@baylibre.com>
Message-ID: <20170131095622.ew56cyjrndu6wxwe@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 05:24:06PM +0100, Neil Armstrong wrote:
> >>> @@ -0,0 +1,79 @@
> >>> +ARM Mali Utgard GPU
> >>> +===================
> >>> +
> >>> +Required properties:
> >>> +  - compatible
> >>> +    * Must be one of the following:
> >>> +      + "arm,mali-300"
> >>> +      + "arm,mali-400"
> >>> +      + "arm,mali-450"
> >>> +    * And, optionally, one of the vendor specific compatible:
> >>> +      + allwinner,sun4i-a10-mali
> >>> +      + allwinner,sun7i-a20-mali
> >>
> >> And stericsson,db8500-mali?
> > 
> > Good catch, I'll add it.
> 
> I think you can safely add the following :
> 
> amlogic,meson-gxbb-mali
> amlogic,meson-gxl-mali

Ack. Do you need any extra properties?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/5555c9f5/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jan 2017 10:38:13 +0100
Subject: [PATCH 1/2] dt-bindings: gpu: Add Mali Utgard bindings
In-Reply-To: <20170116184906.r62di7xiil5lae33@kozik-lap>
References: <20170116132424.7038-1-maxime.ripard@free-electrons.com>
 <20170116184906.r62di7xiil5lae33@kozik-lap>
Message-ID: <20170117093813.mxp2hgoxbgske6ru@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 16, 2017 at 08:49:06PM +0200, Krzysztof Kozlowski wrote:
> On Mon, Jan 16, 2017 at 02:24:23PM +0100, Maxime Ripard wrote:
> > The ARM Mali Utgard GPU family is embedded into a number of SoCs from
> > Allwinner, Amlogic, Mediatek or Rockchip.
> > 
> > Add a binding for the GPU of that family.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  .../devicetree/bindings/gpu/arm,mali-utgard.txt    | 76 ++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> 
> Do you have a driver in kernel which will implement these bindings?

No, but we have bindings for out-of-tree drivers already.

> Defining them for out-of-tree driver does not bring any benefits
> (3rd party driver will not respect them anyway).

You could see it the other way around too. The out-of-tree drivers
don't respect it at the moment because there's no binding to respect.

And at least for us, we definitely plan on doing that.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/a98cc236/attachment.sig>

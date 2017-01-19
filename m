From: robh@kernel.org (Rob Herring)
Date: Thu, 19 Jan 2017 10:08:03 -0600
Subject: [PATCH 1/2] dt-bindings: gpu: Add Mali Utgard bindings
In-Reply-To: <20170117093813.mxp2hgoxbgske6ru@lukather>
References: <20170116132424.7038-1-maxime.ripard@free-electrons.com>
 <20170116184906.r62di7xiil5lae33@kozik-lap>
 <20170117093813.mxp2hgoxbgske6ru@lukather>
Message-ID: <20170119160803.indfxkvvirobmmv6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 10:38:13AM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Jan 16, 2017 at 08:49:06PM +0200, Krzysztof Kozlowski wrote:
> > On Mon, Jan 16, 2017 at 02:24:23PM +0100, Maxime Ripard wrote:
> > > The ARM Mali Utgard GPU family is embedded into a number of SoCs from
> > > Allwinner, Amlogic, Mediatek or Rockchip.
> > > 
> > > Add a binding for the GPU of that family.
> > > 
> > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > ---
> > >  .../devicetree/bindings/gpu/arm,mali-utgard.txt    | 76 ++++++++++++++++++++++
> > >  1 file changed, 76 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> > 
> > Do you have a driver in kernel which will implement these bindings?
> 
> No, but we have bindings for out-of-tree drivers already.
> 
> > Defining them for out-of-tree driver does not bring any benefits
> > (3rd party driver will not respect them anyway).
> 
> You could see it the other way around too. The out-of-tree drivers
> don't respect it at the moment because there's no binding to respect.
> 
> And at least for us, we definitely plan on doing that.

I have no issue taking this. Bindings are in the kernel for 
convenience. Having a driver can help make sure they are complete and 
sound, but otherwise isn't strictly required.

In fact, the ARM folks already asked me about this, but you beat them to 
it (plus it's hard to get them to care about mali400 much).

Rob

From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 10 Sep 2018 19:53:41 +0200
Subject: [PATCH 2/4] dt-bindings: arm: rockchip: Add binding for Rock960
 board
In-Reply-To: <20180910172655.GA4191@Mani-XPS-13-9360>
References: <20180910151356.25946-1-manivannan.sadhasivam@linaro.org>
 <1606406.b630GQBvc1@phil> <20180910172655.GA4191@Mani-XPS-13-9360>
Message-ID: <2934145.U5auXtDNYt@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 10. September 2018, 19:26:55 CEST schrieb Manivannan Sadhasivam:
> Hi Heiko,
> 
> On Mon, Sep 10, 2018 at 07:22:26PM +0200, Heiko Stuebner wrote:
> > Am Montag, 10. September 2018, 17:13:54 CEST schrieb Manivannan Sadhasivam:
> > > Add devicetree binding for Rock960 board from Vamrs Limited.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
> > > index acfd3c773dd0..aaad9e2ff9a3 100644
> > > --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> > > +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> > > @@ -5,6 +5,10 @@ Rockchip platforms device tree bindings
> > >      Required root node properties:
> > >        - compatible = "vamrs,ficus", "rockchip,rk3399";
> > >  
> > > +- 96boards RK3399 Rock960 (ROCK960 Consumer Edition)
> > > +    Required root node properties:
> > > +      - compatible = "vamrs,rk3399-rock960", "rockchip,rk3399";
> > 
> > hmm, are there more boards labeled rock960 from Vamrs?
> > Because I'm trying to determine what makes "vamrs,rock960" unsuitable.
> > 
> 
> Not that I'm aware of but the intention was to follow other RK3399 based
> boards. Anyhow, I have no issues with "vamrs,rock960" if you prefer it!

yep, I think I would prefer it :-)

Looking at the bindings we have, it seems we really have some sort of mix,
but I guess most boards with a real name, just use this one, like all
the google boards or also the ficus itself.

Most of the others are eval boards and fireflys, where the board is actually
unnamed and just uses company name + soc :-)


Heiko

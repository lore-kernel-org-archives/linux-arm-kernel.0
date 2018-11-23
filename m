From: leilk.liu@mediatek.com (lei liu)
Date: Fri, 23 Nov 2018 09:50:00 +0800
Subject: [PATCH 1/2] spi: mediatek: Add bindings for mediatek MT7629 soc
 platform
In-Reply-To: <7bc1777c-fb24-d150-c13f-658c2a33cd71@gmail.com>
References: <1542703268-17285-1-git-send-email-leilk.liu@mediatek.com>
 <1542703268-17285-2-git-send-email-leilk.liu@mediatek.com>
 <7bc1777c-fb24-d150-c13f-658c2a33cd71@gmail.com>
Message-ID: <1542937800.27607.27.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-11-20 at 11:28 +0100, Matthias Brugger wrote:
> 
> On 20/11/2018 09:41, Leilk Liu wrote:
> > This patch adds a DT binding documentation for the MT7629 soc.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >  .../devicetree/bindings/spi/spi-mt65xx.txt         |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> > index 7940940..6cc4e87 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> > @@ -6,6 +6,7 @@ Required properties:
> >      - mediatek,mt2712-spi: for mt2712 platforms
> >      - mediatek,mt6589-spi: for mt6589 platforms
> >      - mediatek,mt7622-spi: for mt7622 platforms
> > +    - mediatek,mt7629-spi: for mt7629 platforms
> 
> That's ok, as you add support in the driver. As it actually doesn't change
> anything in the driver itself you could just describe the binding as something like:
> " mediatek,mt7629-spi", "mediatek,mt7622-spi": for mt7629 platforms
> 
> This way the driver will just probe the driver using the fallback (mt7622)
> compatible, but if you realize in the future that you will need to distinguish
> between the two SoCs, you can add a mt7629 compatible.
> 
> Just as information for the future :)
> 

Got it, thanks for your advice and information :)

> Regards,
> Matthias

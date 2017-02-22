From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 22 Feb 2017 02:51:21 +0100
Subject: [PATCH 1/7] dt-bindings: rockchip-dw-mshc: rename RK1108 to RV1108
In-Reply-To: <20170221233605.wpcqja6hebdrkect@rob-hp-laptop>
References: <1486983566-32265-1-git-send-email-andy.yan@rock-chips.com>
 <1486983759-32337-1-git-send-email-andy.yan@rock-chips.com>
 <20170221233605.wpcqja6hebdrkect@rob-hp-laptop>
Message-ID: <1743495.FQhDfDfeEj@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Am Dienstag, 21. Februar 2017, 17:36:05 CET schrieb Rob Herring:
> On Mon, Feb 13, 2017 at 07:02:39PM +0800, Andy Yan wrote:
> > Rockchip finally named the SOC as RV1108, so change it.
> > 
> > Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> > 
> > ---
> > 
> >  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>

does this Ack span to all dt-centric patches in this series?

As stated in some other mail, should be safe, as the soc isn't on the market 
yet.


Thanks
Heiko

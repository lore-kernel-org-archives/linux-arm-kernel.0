From: briannorris@chromium.org (Brian Norris)
Date: Wed, 7 Dec 2016 09:41:39 -0800
Subject: [PATCH 6/9] dt-bindings: Document rk3399 Gru/Kevin
In-Reply-To: <1720836.rjtWqG8OD3@phil>
References: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
 <1480645653-36943-7-git-send-email-briannorris@chromium.org>
 <1720836.rjtWqG8OD3@phil>
Message-ID: <20161207174139.GA87970@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 06:12:13PM +0100, Heiko Stuebner wrote:
> Hi Brian,
> 
> Am Donnerstag, 1. Dezember 2016, 18:27:30 CET schrieb Brian Norris:
> > Gru is a base dev board for a family of devices, including Kevin. Both
> > utilize Rockchip RK3399, and they share much of their design.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >  Documentation/devicetree/bindings/arm/rockchip.txt | 20
> > ++++++++++++++++++++ 1 file changed, 20 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt
> > b/Documentation/devicetree/bindings/arm/rockchip.txt index
> > cc4ace6397ab..830e13f5890c 100644
> > --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> > @@ -99,6 +99,26 @@ Rockchip platforms device tree bindings
> >  		     "google,veyron-speedy-rev3", "google,veyron-speedy-rev2",
> >  		     "google,veyron-speedy", "google,veyron", "rockchip,rk3288";
> > 
> > +- Google Gru (dev-board):
> 
> boards sorted alphabetically please
> 
> Brian, Gru, Jaq, ... Kevin, ...
> 
> While the sorting of old boards is not right yet, new boards should be sorted.

I got the idea that there was some attempt to group logically before
alphabetically. Like keeping board/SoC families together. But maybe not.

I can do as you suggested, if you don't care about keeping actual
similar boards together (i.e., veyron/3288 vs gru/3399).

Brian

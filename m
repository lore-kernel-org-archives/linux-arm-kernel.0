From: sean.wang@mediatek.com (Sean Wang)
Date: Mon, 8 May 2017 17:53:33 +0800
Subject: [PATCH v2 29/30] dt-bindings: add vendor prefix for bananapi
In-Reply-To: <CAL_JsqKHpWGviZ2H-xhGMzNWsCCRMj_O5ux8aguFfeVKBfJa_w@mail.gmail.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
 <1493198774-4478-30-git-send-email-sean.wang@mediatek.com>
 <20170428203727.m6jm5w6nb2iirxih@rob-hp-laptop>
 <1493621880.32195.13.camel@mtkswgap22>
 <CAL_JsqKHpWGviZ2H-xhGMzNWsCCRMj_O5ux8aguFfeVKBfJa_w@mail.gmail.com>
Message-ID: <1494237213.9662.50.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

thanks for helping me looping in the right group


Hi Arnd and Olof

I found Matthias is inactive for a while (his branch in his tree seemed
to stop at 4.10 since the end of February) maybe he was busy at other
things. Is there a good way to break the stuck situation and keeping
linux-mediatek moving on?

I have the willing to fork his tree, prepare dt-for-4.12 and send
pull-requests to you. But I am worried in that way violating the
reviewing process if Matthias no reads it.

	Sean


On Tue, 2017-05-02 at 08:52 -0500, Rob Herring wrote:
> +arm-soc
> 
> On Mon, May 1, 2017 at 1:58 AM, Sean Wang <sean.wang@mediatek.com> wrote:
> > On Fri, 2017-04-28 at 15:37 -0500, Rob Herring wrote:
> >> On Wed, Apr 26, 2017 at 05:26:13PM +0800, sean.wang at mediatek.com wrote:
> >> > From: Sean Wang <sean.wang@mediatek.com>
> >> >
> >> > Banana Pi team in Sinovoip Co., Limited which are dedicated to
> >> > design and manufacture open hardware product.
> >> >
> >> > Website: http://www.banana-pi.org/
> >> >
> >> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> >> > ---
> >> >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >> >  1 file changed, 1 insertion(+)
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> >> > index ec0bfb9..8ca0f3c 100644
> >> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> >> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> >> > @@ -44,6 +44,7 @@ avia      avia semiconductor
> >> >  avic       Shanghai AVIC Optoelectronics Co., Ltd.
> >> >  axentia    Axentia Technologies AB
> >> >  axis       Axis Communications AB
> >> > +bananapi Banana Pi SINOVOP CO., LIMITED
> >>
> >> s/SINOVOP/SINOVOIP/
> >
> > Hi Rob,
> >
> > thanks for your careful reviewing , i will correct it in the next
> > version.
> >
> > BTW, Could those related dts changes go through your tree if everything
> > looks good? Because I find Matthias have been inactive for a while and
> > the latest branch in his tree seems still staying on 4.10.
> 
> Happy to take binding doc changes, but I don't take dts changes
> because those go thru arm-soc. If the platform maintainer is not
> responsive, then we should replace or add maintainers.
> 
> Rob

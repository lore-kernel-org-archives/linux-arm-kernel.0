From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Wed, 1 Jun 2016 20:04:17 +0800
Subject: [PATCH v2,1/5] dt-bindings: mt8173-xhci: support host side of
 dual-role mode
In-Reply-To: <7828750b-f5ac-6fa0-ee6e-d4775c227e1a@cogentembedded.com>
References: <1464673962-11506-1-git-send-email-chunfeng.yun@mediatek.com>
 <1464673962-11506-2-git-send-email-chunfeng.yun@mediatek.com>
 <7828750b-f5ac-6fa0-ee6e-d4775c227e1a@cogentembedded.com>
Message-ID: <1464782657.11651.136.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2016-05-31 at 14:07 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 5/31/2016 8:52 AM, Chunfeng Yun wrote:
> 
> >
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  .../devicetree/bindings/usb/mt8173-xhci.txt        |   48 ++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> > index b3a7ffa..542e3fa 100644
> > --- a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> > +++ b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> > @@ -2,6 +2,14 @@ MT8173 xHCI
> >
> >  The device node for Mediatek SOC USB3.0 host controller
[...]
> >  Required properties:
> >   - compatible : should contain "mediatek,mt8173-xhci"
> >   - reg : specifies physical base address and size of the registers,
> > @@ -27,6 +35,9 @@ Optional properties:
> >  	control register, it depends on "mediatek,wakeup-src".
> >   - vbus-supply : reference to the VBUS regulator;
> >   - usb3-lpm-capable : supports USB3.0 LPM
> > + - pinctl-names : a pinctrl state named "default" must be defined
> 
>     pinctrl-names.
> 
Thanks.

> > + - pinctrl-0 : pin control group
> > +	See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
> >
> >  Example:
> >  usb30: usb at 11270000 {
> [...]
> 
> MBR, Sergei
> 

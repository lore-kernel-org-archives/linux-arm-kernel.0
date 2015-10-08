From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Thu, 8 Oct 2015 19:37:32 +0800
Subject: [PATCH v9 2/5] dt-bindings: Add a binding for Mediatek xHCI
 host controller
In-Reply-To: <560AA4E0.3030705@cogentembedded.com>
References: <1443495698-32233-1-git-send-email-chunfeng.yun@mediatek.com>
 <1443495698-32233-3-git-send-email-chunfeng.yun@mediatek.com>
 <560AA4E0.3030705@cogentembedded.com>
Message-ID: <1444304252.26198.4.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Tue, 2015-09-29 at 17:49 +0300, Sergei Shtylyov wrote:
> On 09/29/2015 06:01 AM, Chunfeng Yun wrote:
> 
> > add a DT binding documentation of xHCI host controller for the
> > MT8173 SoC from Mediatek.
> >
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >   .../devicetree/bindings/usb/mt8173-xhci.txt        | 52 ++++++++++++++++++++++
> >   1 file changed, 52 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> >
> > diff --git a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> > new file mode 100644
> > index 0000000..0c96273
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> > @@ -0,0 +1,52 @@
> [...]
> > +
> > +Example:
> > +usb30: usb at 11270000 {
> [...]
> > +	status = "okay";
> 
>     This line is not needed.
> 
I will remove it.

Thanks

> [...]
> 
> MBR, Sergei
> 

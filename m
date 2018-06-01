From: jacopo@jmondi.org (jacopo mondi)
Date: Fri, 1 Jun 2018 16:58:27 +0200
Subject: [PATCH v3 2/8] dt-bindings: media: Document data-enable-active
 property
In-Reply-To: <20180601102910.3qhe6bhg3w263chq@paasikivi.fi.intel.com>
References: <1527606359-19261-1-git-send-email-jacopo+renesas@jmondi.org>
 <1527606359-19261-3-git-send-email-jacopo+renesas@jmondi.org>
 <20180601102910.3qhe6bhg3w263chq@paasikivi.fi.intel.com>
Message-ID: <20180601145827.GG10472@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sakari,

On Fri, Jun 01, 2018 at 01:29:10PM +0300, Sakari Ailus wrote:
> Hi Jacopo,
>
> Thanks for the patch.
>
> On Tue, May 29, 2018 at 05:05:53PM +0200, Jacopo Mondi wrote:
> > Add 'data-enable-active' property to endpoint node properties list.
> >
> > The property allows to specify the polarity of the data-enable signal, which
> > when in active state determinates when data lanes have to sampled for valid
> > pixel data.
>
> Lanes or lines? I understand this is forthe parallel interface.
>

Now I'm confused. Are the parallel data 'lines' and the CSI-2 one
'lanes'? I thought 'lanes' applies to both.. am I wrong?

Thanks
   j

> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> > v3:
> > - new patch
> > ---
> >  Documentation/devicetree/bindings/media/video-interfaces.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/media/video-interfaces.txt b/Documentation/devicetree/bindings/media/video-interfaces.txt
> > index 258b8df..9839d26 100644
> > --- a/Documentation/devicetree/bindings/media/video-interfaces.txt
> > +++ b/Documentation/devicetree/bindings/media/video-interfaces.txt
> > @@ -109,6 +109,8 @@ Optional endpoint properties
> >    Note, that if HSYNC and VSYNC polarities are not specified, embedded
> >    synchronization may be required, where supported.
> >  - data-active: similar to HSYNC and VSYNC, specifies data line polarity.
> > +- data-enable-active: similar to HSYNC and VSYNC, specifies the data enable
> > +  signal polarity.
> >  - field-even-active: field signal level during the even field data transmission.
> >  - pclk-sample: sample data on rising (1) or falling (0) edge of the pixel clock
> >    signal.
>
> --
> Sakari Ailus
> sakari.ailus at linux.intel.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180601/da16dd9b/attachment.sig>

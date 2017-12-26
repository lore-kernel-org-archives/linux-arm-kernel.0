From: robh@kernel.org (Rob Herring)
Date: Tue, 26 Dec 2017 15:53:54 -0600
Subject: [linux-sunxi] [PATCH v4 1/2] dt-bindings: media: Add Allwinner
 V3s Camera Sensor Interface (CSI)
In-Reply-To: <20171222100008.nmmzwhtmputizn7d@plaes.org>
References: <1513935689-35415-1-git-send-email-yong.deng@magewell.com>
 <20171222100008.nmmzwhtmputizn7d@plaes.org>
Message-ID: <20171226215354.7h3lvo3w5qb5piuy@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 10:00:08AM +0000, Priit Laes wrote:
> On Fri, Dec 22, 2017 at 05:41:29PM +0800, Yong Deng wrote:
> > Add binding documentation for Allwinner V3s CSI.
> > 
> > Signed-off-by: Yong Deng <yong.deng@magewell.com>
> > ---
> >  .../devicetree/bindings/media/sun6i-csi.txt        | 51 ++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/sun6i-csi.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> > new file mode 100644
> > index 0000000..b5bfe3f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> > @@ -0,0 +1,51 @@
> > +Allwinner V3s Camera Sensor Interface
> > +------------------------------
> 
> Not sure whether syntax for these files is proper reStructuredText/Markdown,
> but the underline-ish style expects the title and underline having same length.

The binding files are not rst/md format, but still the comment is just 
good style.

Rob

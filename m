From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Wed, 20 Jun 2018 17:42:13 +0200
Subject: [PATCH v4 15/19] dt-bindings: media: Document bindings for the
 Sunxi-Cedrus VPU driver
In-Reply-To: <20180620154009.GA26099@rob-hp-laptop>
References: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
 <20180618145843.14631-16-paul.kocialkowski@bootlin.com>
 <20180620154009.GA26099@rob-hp-laptop>
Message-ID: <a2f7b1841410b4a9cd8ac9b5dd323ab2b060acef.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2018-06-20 at 09:40 -0600, Rob Herring wrote:
> On Mon, Jun 18, 2018 at 04:58:39PM +0200, Paul Kocialkowski wrote:
> > This adds a device-tree binding document that specifies the properties
> > used by the Sunxi-Cedurs VPU driver, as well as examples.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > 
> >  create mode 100644 Documentation/devicetree/bindings/media/sunxi-cedrus.txt
> 
> You are missing a '---' line so this is going to end up in the commit 
> msg.

Yes, I can't really explain how this happened. It seems related to
exporting patches with --summary.

> Please add acked/reviewed bys when posting new versions.

Oh, sorry for forgetting that. The bindings are indeed exactly the same
as the ones your reviewed and acked already.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180620/8efc735c/attachment.sig>

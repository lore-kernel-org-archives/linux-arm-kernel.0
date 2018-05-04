From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 4 May 2018 10:12:14 +0200
Subject: [PATCH v2 08/10] dt-bindings: media: Document bindings for the
 Sunxi-Cedrus VPU driver
In-Reply-To: <ce85c790b639bf9101b8c33526bdf149070bcc03.camel@bootlin.com>
References: <20180419154124.17512-1-paul.kocialkowski@bootlin.com>
 <20180419154536.17846-4-paul.kocialkowski@bootlin.com>
 <1524153860.3416.9.camel@pengutronix.de>
 <CAAFQd5DT_xjUbZzFOoKk7_duiSZ8Awb1J=0dPEhVTBk0P3gppA@mail.gmail.com>
 <5fa80b1e88ad2a215f51ea3a2b9b62274fa9b1ec.camel@bootlin.com>
 <20180427030436.3ptrb2ldhtnssipj@rob-hp-laptop>
 <ce85c790b639bf9101b8c33526bdf149070bcc03.camel@bootlin.com>
Message-ID: <20180504081214.3luailyresuq5x4z@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 09:56:20AM +0200, Paul Kocialkowski wrote:
> > > I agree that the term VPU is more commonly associated with video
> > > decoding, while video engine could mean a number of things.
> > > 
> > > The reason I went with "video-engine" here (while still presenting
> > > the
> > > driver as a VPU driver) is that Video Engine is the term used in
> > > Allwinner's litterature. Other nodes in Allwinner device-trees
> > > generally
> > > stick to these terms (for instance, we have "display-engine" nodes).
> > > This also makes it easier to find the matching parts in the
> > > documentation.
> > 
> > 'video-codec' is what is defined in the DT spec.
> 
> Is that an actively-enforced guideline or a suggestion? I'd like to keep
> video-engine just to stick with the technical documentation wording and
> my personal taste is also to prefer vpu over video-codec (in terms of
> clarity/straightforwardness) as a second choice.
> 
> Still, if the choice isn't up to me, we can go with video-codec (or
> vpu).

The unit-name is supposed to reflect the class of the device, and
nothing else. If there's already a pre-existing class name defined for
these kind of devices, then there's no point in choosing something
else.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/edc240ab/attachment.sig>

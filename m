From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 2 Oct 2018 10:31:10 +0200
Subject: [GIT PULL] Allwinner H3/H5 changes for 4.20
In-Reply-To: <CAK8P3a3gF3ywehL-9nkKaiP+JuFtDPXP4RoVo6kLBiEo+_QYgQ@mail.gmail.com>
References: <20180929140729.gnu7i4q6jvv3dblm@flea>
 <CAK8P3a3gF3ywehL-9nkKaiP+JuFtDPXP4RoVo6kLBiEo+_QYgQ@mail.gmail.com>
Message-ID: <20181002083110.ohsjkwizvyip7xop@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Tue, Oct 02, 2018 at 10:24:30AM +0200, Arnd Bergmann wrote:
> On Sat, Sep 29, 2018 at 4:07 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > ----------------------------------------------------------------
> > Allwinner H3 and H5 DT additions for 4.20
> >
> > This is our usual H3/H5 pull request
> >
> > The most notable changes are:
> >   - the video decoding / encoding unit is finally enabled on the H3
> >   - Mali support for the H5
> >   - New boards: BananaPi M2+ v1.2, Orange Pi Zero Plus 2 H3 support
> 
> Good to see the video unit progress. Is the driver also coming for 4.20?

It's been merged through the media tree, yes. The only supported codec
so far is MPEG2 though, but we have patches to enable H264 and H265
decoding that have been submitted already.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181002/37253705/attachment.sig>

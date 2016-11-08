From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 8 Nov 2016 08:44:14 +0100
Subject: [PATCH 3/3] ARM: gr8: evb: Add i2s codec
In-Reply-To: <CAGb2v65bzWJpEnmwk89Qkn+_QawcPtpCJdA+90Dgc68FLRNQqw@mail.gmail.com>
References: <cover.9296840e0b7438e0ae63b4ec0d64957640b64a78.1478524066.git-series.maxime.ripard@free-electrons.com>
 <4d99da31af41b26d9109113e19223ee8b88f76ae.1478524066.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65bzWJpEnmwk89Qkn+_QawcPtpCJdA+90Dgc68FLRNQqw@mail.gmail.com>
Message-ID: <20161108074414.vvnjj7aa26sloi2f@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 10:11:45PM +0800, Chen-Yu Tsai wrote:
> On Mon, Nov 7, 2016 at 9:08 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The GR8-EVB comes with a wm8978 codec connected to the i2s bus.
> >
> > Add a card in order to have it working
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/ntc-gr8-evb.dts | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/ntc-gr8-evb.dts b/arch/arm/boot/dts/ntc-gr8-evb.dts
> > index 12b4317a4383..5291e425caf9 100644
> > --- a/arch/arm/boot/dts/ntc-gr8-evb.dts
> > +++ b/arch/arm/boot/dts/ntc-gr8-evb.dts
> > @@ -76,6 +76,20 @@
> >                 default-brightness-level = <8>;
> >         };
> >
> > +       i2s {
> 
> "sound" might be a better node name? The I2S controllers are also
> named "i2s".

I know, but we also had the codec and SPDIF on this board, so sound
was too generic to be meaningful I guess. I don't really care about
the name though, if you have any suggestion...

> Otherwise,
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161108/9cd82ae9/attachment.sig>

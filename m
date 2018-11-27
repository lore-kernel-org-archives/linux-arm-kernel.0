From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 16:55:26 +0100
Subject: [PATCH v3] ARM: dts: sun8i: Add the H3/H5 CSI controller
In-Reply-To: <CAMty3ZCyFof967vsr7gi=hU2qGcX+A0C2LwLV4hgPCkm1Ta0wQ@mail.gmail.com>
References: <20181120145241.18618-1-maxime.ripard@bootlin.com>
 <CAMty3ZCRdkUdEn7QMCBWcopKr0L0ptBDjdKc0i45A70uEx-YhQ@mail.gmail.com>
 <20181127075359.azs53sydyzakxreq@flea>
 <CAMty3ZCyFof967vsr7gi=hU2qGcX+A0C2LwLV4hgPCkm1Ta0wQ@mail.gmail.com>
Message-ID: <20181127155526.56b3h44axzo3jq43@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 01:36:38PM +0530, Jagan Teki wrote:
> On Tue, Nov 27, 2018 at 1:24 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Tue, Nov 27, 2018 at 11:29:13AM +0530, Jagan Teki wrote:
> > > On Tue, Nov 20, 2018 at 9:53 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > From: Myl?ne Josserand <mylene.josserand@bootlin.com>
> > > >
> > > > The H3 and H5 features the same CSI controller that was initially found on
> > > > the A31.
> > > >
> > > > Add a DT node for it.
> > > >
> > > > Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> > > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > >
> > > > ---
> > > >
> > > > Changes from v3:
> > > >   - Removed the CSI MCLK pin from the default pin group
> > >
> > > If I'm not wrong, PE1 is CSI_MCLK and PE0 is CSI_PCLK so we have PE0
> > > and PE1 removed.
> >
> > i'm not sure what you mean, PCLK is still in that patch.
> 
> PE0 -> CSI_PCLK
> PE1 -> CSI_MCLK
> 
> So, removing CSI MCLK in "Changes from v3" means, removing PE1 right?
> but csi_pins removed PE0 which is CSI_PCLK, we need to remove PE1 from
> csi_pins and keep PE0. isn't it?

Ah, right. I've fixed it up while applying.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/bb525883/attachment.sig>

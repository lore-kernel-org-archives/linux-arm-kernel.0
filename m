From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 20 Aug 2018 16:07:37 +0200
Subject: [PATCH 1/7] dt-bindings: Add DT bindings documentation for
 Allwinner Thermal Sensor Controller
In-Reply-To: <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
References: <20180804070355.14857-1-manu@freebsd.org>
 <20180820111755.rzg7l2lznmbpuf2e@flea>
 <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
Message-ID: <20180820140737.xmqhu5ndqzehvkql@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2018 at 07:41:22AM -0600, Rob Herring wrote:
> On Mon, Aug 20, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Sat, Aug 04, 2018 at 09:03:49AM +0200, Emmanuel Vadot wrote:
> > > This patch adds documentation for Device-Tree bindings for the Allwinner
> > > Thermal Sensor Controller found on the H3, H5 and A64 SoCs
> > >
> > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> >
> > I'm not going to merge a binding for a device that doesn't have any
> > driver implemented at the moment in Linux.
> 
> I'll take it then. Linux is not the only DT client.

Then don't complain if we ever have to break the ABI. We never tested
that hardware, never had any code running on it, and it *will* cause
some issues. For example, the calibration data have never been used
and how they should be represented have never been described, since no
one ever actually tried to use it.

And sure, Linux is not the only DT client. Just like FreeBSD isn't.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180820/c4dad213/attachment.sig>

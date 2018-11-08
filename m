From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 8 Nov 2018 09:21:11 +0100
Subject: [PATCH 11/15] Bluetooth: hci_bcm: Add BCM20702A1 variant
In-Reply-To: <CAGb2v64asgNbYch6gwj0BTTz84=Jfbmu9th0Dyfdx_o8N5tNXg@mail.gmail.com>
References: <20181107101308.7626-1-wens@csie.org>
 <20181107101308.7626-12-wens@csie.org>
 <20181107203608.ff32gmb4u54kcvep@flea>
 <CAGb2v64asgNbYch6gwj0BTTz84=Jfbmu9th0Dyfdx_o8N5tNXg@mail.gmail.com>
Message-ID: <20181108082111.3jt3eukjzfy46kv4@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 08, 2018 at 02:53:33PM +0800, Chen-Yu Tsai wrote:
> On Thu, Nov 8, 2018 at 4:36 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Hi!
> >
> > On Wed, Nov 07, 2018 at 06:13:04PM +0800, Chen-Yu Tsai wrote:
> > > From: Maxime Ripard <maxime.ripard@free-electrons.com>
> > >
> > > The BCM20702A1 chip is a single-chip Bluetooth 4.0 controller and
> > > transceiver. It is found in the AMPAK AP6210 WiFi+BT package.
> > >
> > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > if you resubmit it, could you do s/free-electrons/bootlin/ ?
> 
> OK. And for the author as well?

Yes, please :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181108/9cbfabf5/attachment.sig>

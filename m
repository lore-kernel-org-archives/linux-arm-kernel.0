From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Jul 2017 16:03:44 +0100
Subject: [linux-sunxi] [PATCH 02/10] regulator: add support for SY8106A
 regulator
In-Reply-To: <CAGb2v640bB27M_Xd4r-oQ=acgfpHEwoV2tSk3vH0VZc7R-de6w@mail.gmail.com>
References: <20170723102749.17323-1-icenowy@aosc.io>
 <20170723102749.17323-3-icenowy@aosc.io>
 <CAGb2v640bB27M_Xd4r-oQ=acgfpHEwoV2tSk3vH0VZc7R-de6w@mail.gmail.com>
Message-ID: <20170724150344.4zq6md7eidxzikot@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 11:03:24AM +0800, Chen-Yu Tsai wrote:
> On Sun, Jul 23, 2017 at 6:27 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> > From: Ondrej Jirman <megous@megous.com>
> >
> > SY8106A is an I2C attached single output regulator made by Silergy Corp,
> > which is used on several Allwinner H3/H5 SBCs to control the power
> > supply of the ARM cores.
> >
> > Add a driver for it.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170724/e233edca/attachment.sig>

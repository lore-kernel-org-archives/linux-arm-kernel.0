From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Jan 2015 00:16:29 +0000
Subject: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
In-Reply-To: <1719204322.245040.1422301605670.JavaMail.open-xchange@oxbaltgw03.schlund.de>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
 <20150121230148.GJ13715@earth.universe> <54C0AFE4.3020701@i2se.com>
 <20150125150431.GE2719@earth.universe>
 <1719204322.245040.1422301605670.JavaMail.open-xchange@oxbaltgw03.schlund.de>
Message-ID: <20150127001629.GP21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 08:46:45PM +0100, Stefan Wahren wrote:

> > > Does a common property name exists for the switching frequency or would
> > > it be vendor specific?

> > As far as I know most regulators have fixed switching frequencies,
> > so there is no common property name so far. I added regulator
> > framework people, since this property should be regulator specific.

No, it's pretty common for there to be a couple of options - there's
normally a performance tradeoff (power for regulation accuracy and/or
cost) which can be selected.  IIRC it's selected at design time as it
affect the choice of passives on the board.

> okay i understand. But doesn't it need a extra driver to set the switching
> frequency because of the new compatible string?

I don't understand this bit at all, sorry.

> 
> At this point i think about moving this feature into the bootloader.
> 
> @Fabio, @Marek:
> 
> What's your opinion about that?
> 
> >
> > -- Sebastian
> 
> Stefan
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/224c59a4/attachment.sig>

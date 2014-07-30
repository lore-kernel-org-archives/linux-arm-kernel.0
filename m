From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Jul 2014 13:11:39 +0100
Subject: [PATCH v2 03/12] ASoC: kirkwood: Remove unused drivers
In-Reply-To: <20140729204853.GC17763@lunn.ch>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
 <1405028192-9623-4-git-send-email-andrew@lunn.ch>
 <20140729193509.GK17528@sirena.org.uk>
 <20140729204853.GC17763@lunn.ch>
Message-ID: <20140730121139.GR17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 10:48:53PM +0200, Andrew Lunn wrote:
> On Tue, Jul 29, 2014 at 08:35:09PM +0100, Mark Brown wrote:

> > Applied.  Please send patches against current code, I needed to hand
> > apply this.

> By current do you mean asoc-next? That would not be very easy, since
> i'm patching a large number of subsystems here. I don't think the
> gpio, or the libata, or the led maintainer would be too happy if i
> based the patches on asoc-next! So i picked a plain -rcX kernel,
> something neutral to everybody.

Right, for something like this where the changes are supposed to be
applied in the individual trees rather than merged in -next can be a
reasonable basis.  It's not ideal (and it's pretty unusual for it to
make any sense) but it'll mostly ensure that the patches can be picked
up with relative ease.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140730/af982549/attachment.sig>

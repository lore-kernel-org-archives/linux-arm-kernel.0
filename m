From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 May 2016 10:07:02 +0100
Subject: [RFC PATCH 1/7] ALSA: ac97: split out the generic ac97 registers
In-Reply-To: <87y47roski.fsf@belgarion.home>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-2-git-send-email-robert.jarzmik@free.fr>
 <20160503115159.GP6292@sirena.org.uk>
 <87y47roski.fsf@belgarion.home>
Message-ID: <20160504090702.GV6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2016 at 09:22:05PM +0200, Robert Jarzmik wrote:
> Mark Brown <broonie@kernel.org> writes:

> > On Sat, Apr 30, 2016 at 11:15:33PM +0200, Robert Jarzmik wrote:

> >> Split out from the ac97_codec.h the ac97 generic registers, which can be
> >> used by a codec, typically a generic ac97 codec, and by the ac97 bus, to
> >> scan an ac97 AC-Link.

> > I don't entirely see the value in this one but equally it does no harm.

> Oh that's to have the defines AC97_VENDOR_ID1 and AC97_VENDOR_ID2, but without
> including ac97_codec.h in sound/ac97/bus.c.

I see that, I just don't know why that helps.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160504/dd7af245/attachment.sig>

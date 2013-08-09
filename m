From: broonie@kernel.org (Mark Brown)
Date: Fri, 9 Aug 2013 11:18:42 +0100
Subject: [alsa-devel] [PATCH v4 1/1] ASoc: kirkwood: add DT support to
 the mvebu audio subsystem
In-Reply-To: <5204BF06.3060806@metafoo.de>
References: <20130808132201.2610aef3@armhf> <5204A716.6070507@gmail.com>
 <20130809091953.GO6427@sirena.org.uk> <5204B7A6.9050907@gmail.com>
 <5204BF06.3060806@metafoo.de>
Message-ID: <20130809101842.GR6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 12:05:58PM +0200, Lars-Peter Clausen wrote:
> On 08/09/2013 11:34 AM, Sebastian Hesselbarth wrote:

> > I do understand there may be SoCs requiring sophisticated extra audio
> > nodes, but Marvell SoCs don't. I prefer having a single node for the
> > i2s controller *and* exploit the audio subsystem properties from that.

> It's not about SoCs, it's about the board. The audio fabric on a board can
> easily get complex enough to require its own driver. Speakers, mics, jacks
> and jack detection, external amplifiers, bluetooth, baseband, multiple
> CODECs. That's what the audio node describes.

Exactly - as I said earlier on this week the issue is that in many cases
there is enough going on in audio system design to make the PCB an
interesting bit of hardware that's worth describing in the device tree.

To repeat what I said before *please* go back and check the list
archives, we've been through this several times.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130809/657a714d/attachment.sig>

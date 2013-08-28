From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Aug 2013 14:58:52 +0100
Subject: [PATCH 1/2] ARM: Dove: Add the audio devices in DT
In-Reply-To: <20130828145151.6db29d70@skate>
References: <521DCD33.2070008@gmail.com> <20130828121943.1c8327ca@skate>
 <521DD057.4040208@gmail.com> <20130828131548.0009d613@skate>
 <521DE2B3.9050508@gmail.com> <20130828135827.2307c89e@skate>
 <20130828121320.GK6617@n2100.arm.linux.org.uk>
 <20130828142909.3521064b@skate>
 <20130828124255.GL6617@n2100.arm.linux.org.uk>
 <20130828145151.6db29d70@skate>
Message-ID: <20130828135852.GM6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 28, 2013 at 02:51:51PM +0200, Thomas Petazzoni wrote:
> I don't see how this makes this a different situation. See for example
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/161065.html
> and
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/087702.html
> where Arnd also said using the oldest SoC that has the same IP block as
> the compatible string was the right thing to do.

Well, I have a different opinion, and that's all there is to it.  However,
differing opinions aren't tolerated within the kernel community even if
they are equally valid, so I'll just shut up about after this mail.

> And? If that's a different IP block, it'll have a different compatible
> string, that's it.

There you go, you've just said why there's no problem with using a generic
compatible string.

> It does. We're exactly in this situation, as I will soon be working on
> Armada 370 audio support, and while the IP looks similar, I have
> checked all the details to see if it's exactly identical.

You seem to have missed something in that paragraph.  If it's exactly
identical, there isn't a problem. :)

> And Armada 370 is really a mvebu architecture: it's even supported in
> mach-mvebu/, while Kirkwood and Dove are not (yet).

Maybe it should be mach-kirkwood and not mach-mvebu by your reasoning
then!

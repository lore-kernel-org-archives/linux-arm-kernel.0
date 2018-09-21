From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 21 Sep 2018 17:16:25 +0200
Subject: [PATCH] arm64: dts: allwinner: a64: Re-add "syscon" compatible
In-Reply-To: <20180921153522.0413c280@donnerap.Emea.Arm.com>
References: <20180917152857.162662-1-andre.przywara@arm.com>
 <CAGb2v643=V_3DbLeEyXEavSQJsW2KdknpZZLfw4QwCjhfdmVsA@mail.gmail.com>
 <20180921153522.0413c280@donnerap.Emea.Arm.com>
Message-ID: <20180921151625.wkaypyueyi2pguur@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 03:35:22PM +0100, Andre Przywara wrote:
> The problem is: we broke compatibility with older kernels.

The problem is that we never said we wouldn't.

We've had this discussion a number of times. You forced the backward
compatibility onto us without any warning, and now we have to support
it. And it's already a pain. Maybe ARM can fix that problem by just
assigning more engineers to that, but that's not something we can do.

The fundamental difference is that we're mostly just a bunch of spare
time programmers working on this platform, with a partial
documentation for the controllers, at best.

You forced me to ask these developpers to work on their weekends and
evenings on some crazy corner cases to maintain the backward
compatibility. And honestly, both from a technical and human
standpoint, I definitely understand if some of them are just leaving
and don't want to work on it anymore. I would probably do the same in
their position.

And having to ask that for companies like ARM or SUSE just makes it
more frustrating to be honest. So there's simply no way you have
forward compatibility while I'm there. Or you manage to convince all
the ARM maintainers and enforce that compatibility for all the
platforms.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180921/c6954b27/attachment.sig>

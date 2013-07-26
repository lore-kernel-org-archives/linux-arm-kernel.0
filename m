From: broonie@kernel.org (Mark Brown)
Date: Fri, 26 Jul 2013 14:57:34 +0100
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in	device tree janitoring / cleanup?]
In-Reply-To: <20130725231848.GJ24642@n2100.arm.linux.org.uk>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <CAL_JsqJQWOLC9f1igEpsgJB2X8mFDpqLDaFFRjGGVHctjWZLgQ@mail.gmail.com>
 <20130725193135.GT23879@titan.lakedaemon.net>
 <20130725231848.GJ24642@n2100.arm.linux.org.uk>
Message-ID: <20130726135734.GE9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 12:18:48AM +0100, Russell King - ARM Linux wrote:

> It's actually extremely simple.  If the bindings are in development,
> they must not appear in a -final released kernel.  Anything that appears
> in a -final kernel becomes part of the ABI at that point.

Of course from that point of view there's also an argument that once
people have shipped something on a device or generally out of the review
process then we have to support it no matter how depressing their
choices may have been.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130726/09c3df80/attachment.sig>

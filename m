From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 6 Jul 2012 12:08:44 +0100
Subject: [PATCH] clk: wm831x: fix checkpatch issue for static const char
 * array
In-Reply-To: <CAGsJ_4zruQM8GhGGat_nCmoRd1R3Q-fSHV_OJs=yW6dnOQvYTw@mail.gmail.com>
References: <1341395680-14142-1-git-send-email-Barry.Song@csr.com>
 <20120704101936.GD4111@opensource.wolfsonmicro.com>
 <CAGsJ_4zruQM8GhGGat_nCmoRd1R3Q-fSHV_OJs=yW6dnOQvYTw@mail.gmail.com>
Message-ID: <20120706110843.GB4017@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 10:37:19AM +0800, Barry Song wrote:
> 2012/7/4 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > We need some additional clock API patches to get merged before this is
> > OK, last time I checked the API wasn't const correct enough for it.

> ok. also with this conflict: "warning: initialization discards
> qualifiers from pointer target type"

Yes, that's the issue I'm referring to - we need the clock API to mark
the inputs it takes as const before we can have the drivers declare
thinngs const.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120706/76d0bdc0/attachment.sig>

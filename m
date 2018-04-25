From: broonie@kernel.org (Mark Brown)
Date: Wed, 25 Apr 2018 12:13:13 +0100
Subject: [PATCH v3 2/3] regulator: add support for SY8106A regulator
In-Reply-To: <15C93A9B-6EEB-49EB-A942-35F761E86569@aosc.io>
References: <20180423144657.63264-1-icenowy@aosc.io>
 <20180423144657.63264-3-icenowy@aosc.io>
 <20180424170733.GD22073@sirena.org.uk>
 <C0C1F042-221A-420F-A8C1-5FADCFC687F1@aosc.io>
 <20180425105309.GC24769@sirena.org.uk>
 <15C93A9B-6EEB-49EB-A942-35F761E86569@aosc.io>
Message-ID: <20180425111313.GD24769@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 06:55:10PM +0800, Icenowy Zheng wrote:
> ? 2018?4?25? GMT+08:00 ??6:53:09, Mark Brown <broonie@kernel.org> ??:

> >> SPDX identifier is special -- it should be in a seperated
> >> comment block.

> >No, it just needs to be a C++ comment on the first line to ease machine
> >parsing.  The rest of the file doesn't matter for that.

> Okay. Thus I will use a seperate /* */ block for it in the
> next revision, to follow the rule.

Just make the whole copyright block a C++ comment.  It's much easier and
even with a blank line between the SPDX line and the rest of it it'll
still look messy and odd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180425/364e308d/attachment.sig>

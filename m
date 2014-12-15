From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Dec 2014 12:02:05 +0000
Subject: [PATCH 5/6] dt-bindings: Add documentation for Rockchip hdmi-audio
In-Reply-To: <20141215104029.GE11285@n2100.arm.linux.org.uk>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
 <1418612114-19692-1-git-send-email-ykk@rock-chips.com>
 <20141215104029.GE11285@n2100.arm.linux.org.uk>
Message-ID: <20141215120205.GZ11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 10:40:29AM +0000, Russell King - ARM Linux wrote:

> Including details like this (because ASoC needs a separate DT node) is
> the wrong approach.

And indeed there should be no Linux-internal reason for that - we should
be able to use whatever DT node makes sense, if there's some reason
that's not possible we should fix that (we do have several drivers doing
this sort of thing already though).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141215/c37dc47a/attachment.sig>

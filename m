From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Aug 2013 18:03:42 +0100
Subject: [PATCH RFC 05/13] ASoC: kirkwood: provide
 KIRKWOOD_PLAYCTL_ENABLE_MASK
In-Reply-To: <E1V63wJ-0004lV-FZ@rmk-PC.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V63wJ-0004lV-FZ@rmk-PC.arm.linux.org.uk>
Message-ID: <20130805170342.GV9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 04, 2013 at 08:26:03PM +0100, Russell King wrote:
> Provide a helper macro which includes the sum of all enable bits in
> the playback control register.  This simplifies the code a little.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/41ba0b97/attachment.sig>

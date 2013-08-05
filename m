From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Aug 2013 18:04:28 +0100
Subject: [PATCH RFC 06/13] ASoC: kirkwood: combine kirkwood-i2s and
 kirkwood-dma drivers
In-Reply-To: <E1V63xH-0004lZ-TX@rmk-PC.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V63xH-0004lZ-TX@rmk-PC.arm.linux.org.uk>
Message-ID: <20130805170428.GW9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 04, 2013 at 08:27:03PM +0100, Russell King wrote:
> These really should be a single driver because they're fully integrated
> in hardware.  Make them so.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/fb79a28f/attachment.sig>

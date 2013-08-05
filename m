From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Aug 2013 17:16:04 +0100
Subject: [PATCH RFC 02/13] ASoC: kirkwood: use devm_clk_get() for the
 external clock
In-Reply-To: <E1V63tP-0004lH-4Q@rmk-PC.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V63tP-0004lH-4Q@rmk-PC.arm.linux.org.uk>
Message-ID: <20130805161604.GP9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 04, 2013 at 08:23:03PM +0100, Russell King wrote:
> Use devm_clk_get() to simplify the error path for the external clock.

I've applied the diff that remains from the existing upstream code
(which frees extclk if it's just the internal clock) with a reworded
commit message, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/605f101b/attachment.sig>

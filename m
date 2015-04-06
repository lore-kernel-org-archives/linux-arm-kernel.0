From: broonie@kernel.org (Mark Brown)
Date: Mon, 6 Apr 2015 14:45:41 +0100
Subject: LDP: next-20150402: twl4030 regression?
In-Reply-To: <5522886D.5050409@ti.com>
References: <5522886D.5050409@ti.com>
Message-ID: <20150406134541.GE6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 06, 2015 at 08:21:49AM -0500, Nishanth Menon wrote:

> https://github.com/nmenon/kernel-test-logs/blob/next-20150401/omap2plus_defconfig/ldp.txt
> looks clean, but

> https://github.com/nmenon/kernel-test-logs/blob/next-20150402/omap2plus_defconfig/ldp.txt#L488
> seems to have picked up a regression in the regulator driver.

Please provide actual bug reports if you're trying to report something -
at least a description of the problem you're seeing and some attempt at
analysis.  For example say what the test was, and if there's logs paste
the relevant section into the e-mail.  Just randomly pasting a couple of
web links in and saying "there's a problem" isn't helpful.

Please also CC people responsible for relevant drivers and systems.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150406/cd790810/attachment.sig>

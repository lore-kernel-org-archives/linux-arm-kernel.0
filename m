From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Feb 2015 13:11:27 +0000
Subject: [PATCH V3 13/15] ARM: dts: Exynos4 and Odroid X2/U3 sound device
 nodes update
In-Reply-To: <54D0AB30.2010504@samsung.com>
References: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
 <1421260962-16892-14-git-send-email-s.nawrocki@samsung.com>
 <20150114195452.GM3043@sirena.org.uk>
 <07a501d03f69$aba222b0$02e66810$@kernel.org>
 <54D0AB30.2010504@samsung.com>
Message-ID: <20150203131127.GM21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 12:04:16PM +0100, Sylwester Nawrocki wrote:

> >> Sorry, I should've said - I applied the ASoC patches, not these.

> > Shall I take 13 to 15 DT patches in Samsung tree?

> Patches 13, 14 use macro definitions which are added in patch which is
> already in Mark's sound tree ("ASoC: samsung: i2s: Add clk provider DT
> binding documentation") [1]. We would need to consider that to avoid
> build breaks.

OK, I can apply them if people want but I'd need a resend - I discarded
them since they'd normally go via the arch tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150203/af941f75/attachment.sig>

From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Jan 2015 19:49:24 +0000
Subject: [PATCH V3 00/15] ASoC: samsung: Add clk provider for I2S
 internal clocks
In-Reply-To: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
References: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20150114194924.GJ3043@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 07:42:27PM +0100, Sylwester Nawrocki wrote:
> This series is an attempt to resolve the CDCLK clock gating issue on Odroid
> X2/U3 as reported by Daniel Drake [1], by exposing the CDCLK gate clock
> (and the two other clocks) through clk API. The upside is we can switch
> Odroid X2/U3 to the simple-card, once the CDCLK clock is taken care of by
> the clk core and DT.

Applied all, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/9f0e4b9f/attachment.sig>

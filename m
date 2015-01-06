From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Jan 2015 18:17:01 +0000
Subject: [PATCH v2 00/16] ASoC: samsung: Add clk provider for I2S
 internal clocks
In-Reply-To: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
References: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20150106181701.GR2634@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 02:55:20PM +0100, Sylwester Nawrocki wrote:
> This series is an attempt to resolve the CDCLK clock gating issue on Odroid
> X2/U3 as reported by Daniel Drake [1], by exposing the CDCLK gate clock 
> (and the two other clocks) through clk API. 

This all looks basically fine apart from the comments I made but since I
couldn't apply patch 2 I've not been able to to test anything.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/cb064c54/attachment.sig>

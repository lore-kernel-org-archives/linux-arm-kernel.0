From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Jan 2015 19:54:52 +0000
Subject: [PATCH V3 13/15] ARM: dts: Exynos4 and Odroid X2/U3 sound device
 nodes update
In-Reply-To: <1421260962-16892-14-git-send-email-s.nawrocki@samsung.com>
References: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
 <1421260962-16892-14-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20150114195452.GM3043@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 07:42:40PM +0100, Sylwester Nawrocki wrote:
> Clock related properties are added to the Exynos4 I2S device nodes
> so they can be referred to as clock providers. Missing i2s_opclk1
> clock is added to the I2S0 node and clock properties are added
> to the MAX98090 codec node to allow it to control/read frequency
> of the MCLK clock directly.

Sorry, I should've said - I applied the ASoC patches, not these.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/29480a38/attachment.sig>

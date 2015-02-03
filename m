From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 03 Feb 2015 13:27:07 +0900
Subject: [PATCH V3 13/15] ARM: dts: Exynos4 and Odroid X2/U3 sound device
 nodes update
In-Reply-To: <20150114195452.GM3043@sirena.org.uk>
References: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
 <1421260962-16892-14-git-send-email-s.nawrocki@samsung.com>
 <20150114195452.GM3043@sirena.org.uk>
Message-ID: <07a501d03f69$aba222b0$02e66810$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
Hi Mark,

> On Wed, Jan 14, 2015 at 07:42:40PM +0100, Sylwester Nawrocki wrote:
> > Clock related properties are added to the Exynos4 I2S device nodes
> > so they can be referred to as clock providers. Missing i2s_opclk1
> > clock is added to the I2S0 node and clock properties are added
> > to the MAX98090 codec node to allow it to control/read frequency
> > of the MCLK clock directly.
> 
> Sorry, I should've said - I applied the ASoC patches, not these.

Shall I take 13 to 15 DT patches in Samsung tree?

- Kukjin

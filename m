From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 03 Feb 2015 12:04:16 +0100
Subject: [PATCH V3 13/15] ARM: dts: Exynos4 and Odroid X2/U3 sound device
 nodes update
In-Reply-To: <07a501d03f69$aba222b0$02e66810$@kernel.org>
References: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
 <1421260962-16892-14-git-send-email-s.nawrocki@samsung.com>
 <20150114195452.GM3043@sirena.org.uk>
 <07a501d03f69$aba222b0$02e66810$@kernel.org>
Message-ID: <54D0AB30.2010504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/15 05:27, Kukjin Kim wrote:
> Mark Brown wrote:
>> On Wed, Jan 14, 2015 at 07:42:40PM +0100, Sylwester Nawrocki wrote:
>>> Clock related properties are added to the Exynos4 I2S device nodes
>>> so they can be referred to as clock providers. Missing i2s_opclk1
>>> clock is added to the I2S0 node and clock properties are added
>>> to the MAX98090 codec node to allow it to control/read frequency
>>> of the MCLK clock directly.
>>
>> Sorry, I should've said - I applied the ASoC patches, not these.
> 
> Shall I take 13 to 15 DT patches in Samsung tree?

Patches 13, 14 use macro definitions which are added in patch which is
already in Mark's sound tree ("ASoC: samsung: i2s: Add clk provider DT
binding documentation") [1]. We would need to consider that to avoid
build breaks.

--
Thanks,
Sylwester

[1]
https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=0d40c61279510b8ce2368e1c6adcc2c4dc1af279

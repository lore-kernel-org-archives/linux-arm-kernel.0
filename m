From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 31 May 2010 12:20:41 +0100
Subject: [patch 3/6] soc-dapm.h: add SND_SOC_DAPM_PRE_POST_PMD event
In-Reply-To: <20100527130338.487101110@mandriva.com>
References: <20100527125737.524554667@mandriva.com>
	<20100527130338.487101110@mandriva.com>
Message-ID: <20100531112040.GG3489@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 02:57:40PM +0200, apatard at mandriva.com wrote:
> Some systems codecs need to configure some registers before and after powering down
> some of their part. As a convenience, I'm adding a macro for that.
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

Applied with modified changelog, thanks.

Please put an appropriate prefix on patches you submit ("ASoC: " for
ASoC) - this makes it easier to apply.

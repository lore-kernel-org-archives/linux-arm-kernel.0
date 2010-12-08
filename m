From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Dec 2010 17:11:40 +0000
Subject: [PATCHv3] support PMIC mc13892
In-Reply-To: <87r5dsl4s7.fsf@lechat.rtp-net.org>
References: <1291778460-22819-1-git-send-email-yong.shen@freescale.com>
	<1291778460-22819-2-git-send-email-yong.shen@freescale.com>
	<20101208091226.GD18244@pengutronix.de>
	<20101208100138.GB16418@rakim.wolfsonmicro.main>
	<87r5dsl4s7.fsf@lechat.rtp-net.org>
Message-ID: <20101208171140.GS16418@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 03:26:16PM +0100, Arnaud Patard wrote:
> >> > +#define MC13892_PWGT1SPI	21
> >> > +#define MC13892_PWGT2SPI	22
> >> > +#define MC13892_VCOINCELL	23

> If we move this header into drivers/regulator, how are we supposed to
> declared regulators in the machine file ?

Oh, fail, yes - with this interface you do need to put the defines where
the machine driver can see them.

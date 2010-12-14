From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Tue, 14 Dec 2010 15:52:20 +0000
Subject: [PATCH 1/3] Change the register name definitions for mc13783
In-Reply-To: <1292306455-26752-2-git-send-email-yong.shen@freescale.com>
References: <1292306455-26752-1-git-send-email-yong.shen@freescale.com>
	<1292306455-26752-2-git-send-email-yong.shen@freescale.com>
Message-ID: <1292341940.3316.12.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-12-14 at 14:00 +0800, yong.shen at freescale.com wrote:
> From: Yong Shen <yong.shen@linaro.org>
> 
> To make mc13783 and mc13892 share code, the register names should be
> changed to fit the new macro definitions in the comming patch.
> 
> Signed-off-by: Yong Shen <yong.shen@linaro.org>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-imx/mach-pcm038.c       |    4 +-
>  arch/arm/mach-mx3/mach-mx31_3ds.c     |    4 +-
>  arch/arm/mach-mx3/mach-mx31moboard.c  |    4 +-
>  drivers/regulator/mc13783-regulator.c |   30 +++++++-------
>  include/linux/mfd/mc13783.h           |   67 +++++++++++++++++----------------
>  5 files changed, 55 insertions(+), 54 deletions(-)

All applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

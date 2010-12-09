From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Thu, 09 Dec 2010 12:59:26 +0000
Subject: [PATCHv3] support PMIC mc13892
In-Reply-To: <20101209102526.GN6017@pengutronix.de>
References: <1291778460-22819-1-git-send-email-yong.shen@freescale.com>
	<1291778460-22819-2-git-send-email-yong.shen@freescale.com>
	<20101209102526.GN6017@pengutronix.de>
Message-ID: <1291899566.3271.135.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-12-09 at 11:25 +0100, Sascha Hauer wrote:
> On Wed, Dec 08, 2010 at 11:21:00AM +0800, yong.shen at freescale.com wrote:
> > From: Yong Shen <yong.shen@linaro.org>
> > 
> > add support for mc13892, tested on mx51 babbage board
> > 
> > Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> > Signed-off-by: Yong Shen <yong.shen@linaro.org>
> 
> As there seem to be only whitespace changes left to worry about:
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> 

Thanks Sascha. 

Are you also happy with his other MC139892 patch. I believe both you and
Uwe were involved in the review. It's fine from regulator pov, just best
to get your Ack re the mxc changes :-

>From e112153c6f03b49c229a8e3913a0c0459245df20 Mon Sep 17 00:00:00 2001
From: Yong Shen <yong.shen@linaro.org>
Date: Thu, 2 Dec 2010 14:17:02 +0800
Subject: [PATCH 1/2] Change the register name definitions for mc13783

To make mc13783 and mc13892 share code, the register names should be
changed to fit the new macro definitions in the comming patch.

Signed-off-by: Yong Shen <yong.shen@linaro.org>

---
 arch/arm/mach-imx/mach-pcm038.c       |    4 +-
 arch/arm/mach-mx3/mach-mx31_3ds.c     |    4 +-
 arch/arm/mach-mx3/mach-mx31moboard.c  |    4 +-
 drivers/regulator/mc13783-regulator.c |   30 +++++++-------
 include/linux/mfd/mc13783.h           |   67 +++++++++++++++++----------------
 5 files changed, 55 insertions(+), 54 deletions(-)

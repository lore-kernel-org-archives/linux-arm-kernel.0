From: linuxzsc@gmail.com (Richard Zhao)
Date: Thu, 30 Dec 2010 22:35:07 +0800
Subject: [PATCH v2 1/2] ARM i.MX53: Some bug fix about MX53 MSL code
In-Reply-To: <20101230095401.GW14221@pengutronix.de>
References: <1293686881-15046-1-git-send-email-yong.shen@freescale.com>
	<1293686881-15046-2-git-send-email-yong.shen@freescale.com>
	<20101230095401.GW14221@pengutronix.de>
Message-ID: <AANLkTi=eHN=NY6XxKr5X9w2ADNO+2ZOCskGOtDst71E_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Do you think we need to add postfix -mx51-mx53 to all mx51/53 specific
files :arch/arm/mach-mx5: cpu.c devices.c mm.c crm_regs.h devices.h ?
And add obj-$(CONFIG_SOC_IMX51) := xxxxxxxxxxxxxxxx to Makefile.

Thanks
Richard

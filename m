From: timur@freescale.com (Timur Tabi)
Date: Sat, 21 Nov 2009 20:12:34 -0600
Subject: [PATCH 06/12] imx-ssi sound driver
In-Reply-To: <1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
Message-ID: <ed82fe3e0911211812i49342b0eg2afe861c866db90c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 9:48 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> ?arch/arm/plat-mxc/Makefile ? ? ? ? ? | ? ?1 +
> ?arch/arm/plat-mxc/include/mach/ssi.h | ? 17 +
> ?arch/arm/plat-mxc/ssi-fiq.S ? ? ? ? ?| ?134 ++++
> ?sound/soc/imx/devdma.c ? ? ? ? ? ? ? | ? 80 ++
> ?sound/soc/imx/devdma.h ? ? ? ? ? ? ? | ? ?3 +
> ?sound/soc/imx/imx-ssi.c ? ? ? ? ? ? ?| 1349 ++++++++++++++++++++++++++++++++++
> ?sound/soc/imx/imx-ssi.h ? ? ? ? ? ? ?| ? 24 +

Why did you write a new SSI driver when there already is one in sound/soc/fsl?

-- 
Timur Tabi
Linux kernel developer at Freescale

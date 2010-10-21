From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Thu, 21 Oct 2010 21:47:39 +0200
Subject: [PATCH v4] imx-esdhc: update devices registration
In-Reply-To: <20101020154430.GF19834@pengutronix.de>
References: <20101012153155.GE4470@pengutronix.de>
	<1286904825-6432-1-git-send-email-eric@eukrea.com>
	<20101020145532.GD19834@pengutronix.de> <4CBF0553.30000@eukrea.com>
	<20101020154430.GF19834@pengutronix.de>
Message-ID: <4CC098DB.6010406@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 20/10/2010 17:44, Uwe Kleine-K?nig a ?crit :
> ARM: mx3: fix build failure concerning MXC_INT_MMC_SDHC2
>
> From: Uwe Kleine-K?nig<u.kleine-koenig@pengutronix.de>
>
> Commit c074512 (imx-esdhc: update devices registration) renamed
> MX35_INT_MMC_SDHC2 to MX35_INT_ESDHC2 which broke expansion of the
> MXC_INT_MMC_SDHC2 macro.
> As  (the only user of MXC_INT_MMC_SDHC2) is only used on
> mx31 use the MX31 prefixed symbol to define its resources.  Moreover to
> reduce further confusion mxcsdhc_device0 is fixed accordingly and the MXC
> prefixed symbols are removed.
>
> Signed-off-by: Uwe Kleine-K?nig<u.kleine-koenig@pengutronix.de>

Tested-by: Eric B?nard <eric@eukrea.com>

This allow mx3_defconfig to compile (using the updated one from my defconfig 
patch serie).

Eric

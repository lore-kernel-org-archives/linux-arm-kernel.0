From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 8 Dec 2010 11:49:43 +0100
Subject: [PATCH v2 1/2] ARM: mx5: introduce SOC_IMX51
In-Reply-To: <AANLkTi=4p6_2ub0WeSBfnFJubtgqa6QLC06hUXTWdFo1@mail.gmail.com>
References: <1290724946-23516-1-git-send-email-user@fabio-desktop>
	<20101126113639.GD27637@pengutronix.de>
	<AANLkTi=4p6_2ub0WeSBfnFJubtgqa6QLC06hUXTWdFo1@mail.gmail.com>
Message-ID: <20101208104943.GM18244@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 06:32:01PM +0800, Richard Zhao wrote:
> Hi Fabio and Uwe,
> 
> Why do we have both ARCH_MX51 and SOC_IMX51? It looks redundant.
> Will ARCH_MX51 be removed after all other places are replace by SOC_IMX51?
yes
 
> I don't need to define ARCH_MX50 any more, correct?
The motivation for SOC_... is described in arch/arm/mach-mx3/Kconfig[1].
So if you have multi-soc kernels in mind when using SOC_IMX50 not adding
ARCH_MX50 is fine (and prefered).

Best regards
UWe

[1]
http://git.pengutronix.de/?p=imx/linux-2.6.git;a=blob;f=arch/arm/mach-mx3/Kconfig;hb=imx-for-2.6.38

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

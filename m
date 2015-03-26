From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 26 Mar 2015 09:12:38 +0100
Subject: [PATCH] ARM: dts: vf610: fix missing irqs
In-Reply-To: <1427354645-16629-1-git-send-email-stefan@agner.ch>
References: <1427354645-16629-1-git-send-email-stefan@agner.ch>
Message-ID: <20150326081238.GK32677@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stefan,

On Thu, Mar 26, 2015 at 08:24:05AM +0100, Stefan Agner wrote:
> While adding the MSCM interrupt router, all interrupts have been moved
> to vfxxx.dtsi again. However, some properties got lost. Readd the
> missing interrupt properties.
> 
> Offending commit:
> 97e6466ab9 ("ARM: dts: vf610: add Miscellaneous System Control Module (MSCM)"
Usually this is written as:

	Fixes: 97e6466ab9 ("ARM: dts: vf610: add Miscellaneous System Control Module (MSCM)")

and there is no Sign-off.

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

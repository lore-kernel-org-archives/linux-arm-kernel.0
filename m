From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 4 Feb 2010 12:06:22 +0000
Subject: [PATCH 08/25] imx/mx1: rename files defining a machine to
	mach-$mach.c
In-Reply-To: <20100204012916.GC5274@k2>
References: <20100108161551.GA19007@pengutronix.de>
	<1262967452-24353-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100204012916.GC5274@k2>
Message-ID: <20100204120622.GB20282@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2010 at 05:29:16PM -0800, Amit Kucheria wrote:
> On 10 Jan 08, Uwe Kleine-K??nig wrote:

> >  rename arch/arm/mach-mx1/{mx1ads.c => mach-mx1ads.c} (98%)
> >  rename arch/arm/mach-mx1/{scb9328.c => mach-scb9328.c} (98%)

> Rethinking about this (based on a similar request for my i.MX5 submission), I
> think renaming the boards to mach-* is a bad idea.

> Other SoCs (davinci, omap, msm, nomadik, etc.) use the board-* convention. We
> already use mach-* for the SoC directory names under arch/arm/. Naming the
> boards with mach-* will just cause more confusion.

Some other socs (at least the Samsung ones) are using mach- :/

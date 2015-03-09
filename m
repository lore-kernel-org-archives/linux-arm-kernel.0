From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 09 Mar 2015 11:16:47 +0100
Subject: [PATCH v2 04/10] Documentation: bindings: move the Berlin reset
 documentation
In-Reply-To: <1425654328-26298-5-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
 <1425654328-26298-5-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425896207.3152.26.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 06.03.2015, 16:05 +0100 schrieb Antoine Tenart:
> The Berlin reset documentation was part of the Marvell Berlin SoC
> documentation because the Berlin reset configuration was inside the chip
> controller. With the recent rework of the chip and system controller
> handling (now an MFD driver registers all sub-devices of the two soc and
> system controller nodes and each device has its own sub-node), the
> documentation of the Berlin reset driver can be moved to the generic
> reset documentation directory.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

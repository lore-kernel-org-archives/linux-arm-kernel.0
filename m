From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 24 Jun 2014 13:14:23 +0200
Subject: [PATCH v2 04/12] ARM: dts: berlin: add a required reset
 property in the chip controller node
In-Reply-To: <1403606121-6368-5-git-send-email-antoine.tenart@free-electrons.com>
References: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
 <1403606121-6368-5-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1403608463.2910.17.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 24.06.2014, 12:35 +0200 schrieb Antoine T?nart:
> The chip controller node now also describes the Marvell Berlin reset
> controller. Add the required 'reset-cells' property.
> 
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

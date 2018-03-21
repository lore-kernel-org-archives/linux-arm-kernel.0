From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 21 Mar 2018 14:23:21 +0100
Subject: [PATCH 1/3] arm64: dts: marvell: armada-37xx: mark the gpio
 controllers as irq controller
In-Reply-To: <20180321105005.18426-1-u.kleine-koenig@pengutronix.de>
References: <20180321105005.18426-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20180321132321.GE11206@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 11:50:03AM +0100, Uwe Kleine-K?nig wrote:
> This allows to reference these gpio controller as interrupt parent. Also
> add a comment which cpu line names are managed by the controllers
> because "nb" and "sb" usually doesn't appear in schematics, but MPPX_Y
> do.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

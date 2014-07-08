From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 8 Jul 2014 08:46:11 +0200
Subject: [PATCH CFT 02/30] net: fec: iMX6 FEC does not support
 half-duplex gigabit
In-Reply-To: <E1X0Xvb-0001Mu-JB@rmk-PC.arm.linux.org.uk>
References: <20140627151542.GL32514@n2100.arm.linux.org.uk>
 <E1X0Xvb-0001Mu-JB@rmk-PC.arm.linux.org.uk>
Message-ID: <20140708064611.GF7827@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Jun 27, 2014 at 04:19:03PM +0100, Russell King wrote:
> The iMX6 gigabit FEC does not support half-duplex gigabit operation.
> Phys attacked to the FEC may support this, and we currently do nothing
Even if it might be interpreted as an attack to connect such a phy to
the FEC, I'd still call it "attach" here :-)

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 11 Sep 2014 10:47:18 +0200
Subject: [PATCH 1/5] ARM: dts: pbab01: move i2c pins and frequency
 configuration into pfla02
In-Reply-To: <1410356809-26179-2-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410356809-26179-2-git-send-email-d.lavnikevich@sam-solutions.com>
Message-ID: <1410425238.4011.18.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 10.09.2014, 16:46 +0300 schrieb Dmitry Lavnikevich:
> Since pins and frequency are specific to module (pfla02), not base board
> (pbab02), it is better to be initialized in corresponding dts file.
> 
> Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>

I have seen boards use the GPIO_3/6 pads instead of EIM_D17/D18 for
I2C3, but the EIM_D17/D18 are indeed documented as "I2C1" pins at the
pfla02 connector level.

regards
Philipp

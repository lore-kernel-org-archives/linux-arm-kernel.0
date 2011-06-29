From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jun 2011 13:41:48 +0200
Subject: [PATCH 1/2] PWM: add pwm framework support
In-Reply-To: <1309338215-10702-2-git-send-email-s.hauer@pengutronix.de>
References: <1309338215-10702-1-git-send-email-s.hauer@pengutronix.de>
	<1309338215-10702-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <201106291341.48317.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 June 2011, Sascha Hauer wrote:
> This patch adds framework support for PWM (pulse width modulation) devices.

Hi Sascha,

The code looks all good now, but it seems you missed the three trivial remarks
I had about the documentation. It would be good to just fix them, but not
essential.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

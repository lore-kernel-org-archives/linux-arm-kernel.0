From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 17 Nov 2010 08:55:47 +0200
Subject: [PATCH 2/2] h1940-leds: Fix compile issue introduced by
	latch-related changes
In-Reply-To: <4CE30FFA.7000204@fluff.org>
References: <1289248308-21272-1-git-send-email-anarsoul@gmail.com>
	<1289248308-21272-2-git-send-email-anarsoul@gmail.com>
	<4CE30FFA.7000204@fluff.org>
Message-ID: <201011170855.47991.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 November 2010 01:12:58 Ben Dooks wrote:

> it's a pitty we can't remove the driver totally and use the
> gpio leds.

Why? It's possible to use leds-gpio driver. Additional gpios (blink, etc) can 
be handled via platform_gpio_blink_set callback.

Regards
Vasily

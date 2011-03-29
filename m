From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 29 Mar 2011 15:58:26 +0300
Subject: [PATCH] s3c2440: mini2440: Use leds-gpio driver for board leds
	handling.
In-Reply-To: <1301392380-9022-1-git-send-email-marek.belisko@open-nandra.com>
References: <AANLkTi=RW0o=+hXcO0Y04nq10QEd=hWY0Nzc0enJ=Tr7@mail.gmail.com>
	<1301392380-9022-1-git-send-email-marek.belisko@open-nandra.com>
Message-ID: <201103291558.26624.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2011 12:53:00 Marek Belisko wrote:
> Intention of this patch is convert existing usage of leds-s3c24xx driver
> to use generic gpio-leds driver. Leds are separated to 2 devices.
> First device handle 4 available leds. Second device is used to drive
> LCD backlight. Backlight can be controlled via parameter b so we need
> separate device which is registered or not depending on parameter.
> 
> Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>

You also need to remove mach/leds-gpio.h include, you don't need it anymore, 
right? Rest part looks good for me.

Regards
Vasily

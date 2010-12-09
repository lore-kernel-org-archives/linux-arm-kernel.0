From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 10 Dec 2010 00:16:57 +0200
Subject: [PATCH] leds/h1940: Use gpiolib for latch access / fix build
	failure
In-Reply-To: <1291932292-16049-1-git-send-email-peterhuewe@gmx.de>
References: <1291932292-16049-1-git-send-email-peterhuewe@gmx.de>
Message-ID: <201012100016.58130.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 December 2010 00:04:52 Peter Huewe wrote:
> This patch fixes a build failure by converting leds-h1940.c to use
> gpiolib for latch access introduced by 14477095abc6
> (ARM: h1940: Use gpiolib for latch access)
> 
> Unfortunately this driver was not converted back then.

I sent similar patch (however, my patch does gpio_request/gpio_free) ~month 
ago.

Here's link:
http://www.spinics.net/lists/arm-kernel/msg103429.html

Regards
Vasily

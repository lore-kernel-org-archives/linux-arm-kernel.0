From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 6 Jan 2011 18:03:25 +0200
Subject: [PATCH] leds/h1940: Use gpiolib for latch access / fix build
	failure
In-Reply-To: <20110104153725.2f3fede2.akpm@linux-foundation.org>
References: <1291932292-16049-1-git-send-email-peterhuewe@gmx.de>
	<201012100016.58130.anarsoul@gmail.com>
	<20110104153725.2f3fede2.akpm@linux-foundation.org>
Message-ID: <201101061803.26194.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 January 2011 01:37:25 Andrew Morton wrote:

> So which patch to use?
> 
> I queued Peter's patch because it's simpler.  I queued it for
> 2.6.38-rc1, taged for backporting into 2.6.37.x, so we have a bit of
> time to think about it.

Anyway, it's time to drop leds-h1940 driver, I'll submit patch to support 
H1940 leds via generic leds-gpio driver tonight.

Regards
Vasily

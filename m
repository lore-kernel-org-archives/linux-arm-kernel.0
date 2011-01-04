From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 4 Jan 2011 15:37:25 -0800
Subject: [PATCH] leds/h1940: Use gpiolib for latch access / fix build
	failure
In-Reply-To: <201012100016.58130.anarsoul@gmail.com>
References: <1291932292-16049-1-git-send-email-peterhuewe@gmx.de>
	<201012100016.58130.anarsoul@gmail.com>
Message-ID: <20110104153725.2f3fede2.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Dec 2010 00:16:57 +0200
Vasily Khoruzhick <anarsoul@gmail.com> wrote:

> On Friday 10 December 2010 00:04:52 Peter Huewe wrote:
> > This patch fixes a build failure by converting leds-h1940.c to use
> > gpiolib for latch access introduced by 14477095abc6
> > (ARM: h1940: Use gpiolib for latch access)
> > 
> > Unfortunately this driver was not converted back then.
> 
> I sent similar patch (however, my patch does gpio_request/gpio_free) ~month 
> ago.
> 
> Here's link:
> http://www.spinics.net/lists/arm-kernel/msg103429.html
> 

So which patch to use?

I queued Peter's patch because it's simpler.  I queued it for
2.6.38-rc1, taged for backporting into 2.6.37.x, so we have a bit of
time to think about it.

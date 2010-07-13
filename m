From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Jul 2010 21:08:32 +0100
Subject: [PATCH v2 0/3] s3c24xx: iPAQ rx1950 series
In-Reply-To: <201007132129.32029.anarsoul@gmail.com>
References: <1278781069-30521-1-git-send-email-anarsoul@gmail.com>
	<201007132005.50412.anarsoul@gmail.com>
	<20100713180303.GA9457@rakim.wolfsonmicro.main>
	<201007132129.32029.anarsoul@gmail.com>
Message-ID: <20100713200831.GA25380@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 09:29:27PM +0300, Vasily Khoruzhick wrote:
> ? ????????? ?? 13 ???? 2010 21:03:03 ????? Mark Brown ???????:
> > If an application tries to set the LED brightness but the LED actually
> > starts blinking that sounds bad...

> Yeah, but how some driver from kernel should make LED blink when LED driver 
> defines blink_set callback?

I don't know off the top of by head but if that's not currently possible
then surely the way forward is to add this new functionality rather than
introduce breakage?

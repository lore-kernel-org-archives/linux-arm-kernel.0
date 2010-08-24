From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 24 Aug 2010 16:41:57 +0200
Subject: [PATCH 3/3] h1940: implement mmc_power function
In-Reply-To: <201008241721.11669.anarsoul@gmail.com>
References: <1282230003-2020-1-git-send-email-anarsoul@gmail.com>
	<201008241601.12355.marek.vasut@gmail.com>
	<201008241721.11669.anarsoul@gmail.com>
Message-ID: <201008241641.57621.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 24. srpna 2010 16:21:01 Vasily Khoruzhick napsal(a):
> ? ????????? ?? 24 ??????? 2010 17:01:12 ????? Marek Vasut ???????:
> > pr_err() and don't probe the device for which you couldn't request GPIO.
> 
> Well, handling those errors in machine init functions doesn't make sense.
> PDA is not usable without basic hardware.
> 
You can use PDA without LCD for example (there are such people, trust me). So, 
this comment really isn't too valid. You can also use PDA without MMC support, 
you still have onboard flash, etc. etc.

Cheers

> Regards
> Vasily

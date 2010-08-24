From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 24 Aug 2010 17:04:14 +0200
Subject: [PATCH 1/3] h1940: use gpiolib for latch access
In-Reply-To: <201008241750.43535.anarsoul@gmail.com>
References: <1282230003-2020-1-git-send-email-anarsoul@gmail.com>
	<201008241640.21488.marek.vasut@gmail.com>
	<201008241750.43535.anarsoul@gmail.com>
Message-ID: <201008241704.14566.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 24. srpna 2010 16:50:36 Vasily Khoruzhick napsal(a):
> ? ????????? ?? 24 ??????? 2010 17:40:21 ????? Marek Vasut ???????:
> > Defining S3C2410_GPH_GPIONAME for each bit might be better then.
> 
> Well, that requires massive refactoring of h1940 (and rx1950) support. And
> btw, that's common for s3c24xx-based machines to use generic s3c24xx gpio
> names, not machine specific.

I assume I see how it works now. Ok, please put a comment around it then so 
others will understand what it does.

Using machine-specific GPIO names might help readability btw. -- the approach 
"everyone does it this way so I'll do it this way without thinking" is bad :)

Well, it's just my suggestion for improvement of the overall code quality. Ben, 
what's your opinion?

Cheers
> 
> Regards
> Vasily

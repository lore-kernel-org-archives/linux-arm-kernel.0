From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 24 Aug 2010 17:50:36 +0300
Subject: [PATCH 1/3] h1940: use gpiolib for latch access
In-Reply-To: <201008241640.21488.marek.vasut@gmail.com>
References: <1282230003-2020-1-git-send-email-anarsoul@gmail.com>
	<201008241704.07384.anarsoul@gmail.com>
	<201008241640.21488.marek.vasut@gmail.com>
Message-ID: <201008241750.43535.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 24 ??????? 2010 17:40:21 ????? Marek Vasut ???????:

> Defining S3C2410_GPH_GPIONAME for each bit might be better then.

Well, that requires massive refactoring of h1940 (and rx1950) support. And 
btw, that's common for s3c24xx-based machines to use generic s3c24xx gpio 
names, not machine specific.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100824/51ad203a/attachment.sig>

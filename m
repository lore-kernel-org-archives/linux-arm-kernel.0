From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 24 Aug 2010 17:21:01 +0300
Subject: [PATCH 3/3] h1940: implement mmc_power function
In-Reply-To: <201008241601.12355.marek.vasut@gmail.com>
References: <1282230003-2020-1-git-send-email-anarsoul@gmail.com>
	<201008241700.31513.anarsoul@gmail.com>
	<201008241601.12355.marek.vasut@gmail.com>
Message-ID: <201008241721.11669.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 24 ??????? 2010 17:01:12 ????? Marek Vasut ???????:

> pr_err() and don't probe the device for which you couldn't request GPIO.

Well, handling those errors in machine init functions doesn't make sense. PDA 
is not usable without basic hardware.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100824/828fe421/attachment.sig>

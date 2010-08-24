From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 24 Aug 2010 18:19:37 +0300
Subject: [PATCH 3/3] h1940: implement mmc_power function
In-Reply-To: <201008241707.31629.marek.vasut@gmail.com>
References: <1282230003-2020-1-git-send-email-anarsoul@gmail.com>
	<201008241756.11529.anarsoul@gmail.com>
	<201008241707.31629.marek.vasut@gmail.com>
Message-ID: <201008241819.43833.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 24 ??????? 2010 18:07:31 ????? Marek Vasut ???????:
> See my previous response. It'd increase code size, but if you mark that
> code __init, it'll be freed after that function finishes so it doesn't
> matter.
> 
> If something wrong goes on, you can still debug it without for example MMC
> card (though if you continued probing the MMC driver, it might cause
> additional unwanted noise and make the debugging harder). That's the whole
> point.

Ok, but I also want to hear Ben's opinion on this point.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100824/247d8297/attachment.sig>

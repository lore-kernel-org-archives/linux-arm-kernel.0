From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Fri, 26 Sep 2014 10:40:54 +0800
Subject: [PATCH resend] arm:extend the reserved memory for initrd to be
 page aligned
In-Reply-To: <20140925154403.GL10390@e104818-lin.cambridge.arm.com>
References: <35FD53F367049845BC99AC72306C23D103D6DB49161F@CNBJMBX05.corpusers.net>
 <20140919095959.GA2295@e104818-lin.cambridge.arm.com>
 <20140925143142.GF5182@n2100.arm.linux.org.uk>
 <20140925154403.GL10390@e104818-lin.cambridge.arm.com>
Message-ID: <35FD53F367049845BC99AC72306C23D103D6DB49163B@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> They were so close ;)
> 
> I can see three patches but none of them exactly right:
> 
> 8157/1 - wrong diff format
> 8159/1 - correct format, does not have my ack (you can take this one if
> 	 you want)
> 8162/1 - got my ack this time but with the wrong diff format again
> 
> Maybe a pull request is a better idea.
> 
I am really confused, 
I read this web:
http://www.arm.linux.org.uk/developer/patches/info.php
it said use diff -urN to generate patch like this:

diff -Nru linux.orig/lib/string.c linux/lib/string.c

but I see other developers use git format-patch to generate patch and
submit to the patch system.
Git format-patch format can also be accepted by the patch system correctly ?
If yes, I think this web should update,
Use git format-patch to generate patch is more convenient than use diff -urN 

Thanks

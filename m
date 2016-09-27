From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 27 Sep 2016 18:26:00 +0200
Subject: [PATCH] usb: Convert pr_warning to pr_warn
In-Reply-To: <f86b512272987e0faeaccbe6466665175eaefe9a.1474992979.git.joe@perches.com>
 (Joe Perches's message of "Tue, 27 Sep 2016 09:16:59 -0700")
References: <f86b512272987e0faeaccbe6466665175eaefe9a.1474992979.git.joe@perches.com>
Message-ID: <87d1jpb97r.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joe Perches <joe@perches.com> writes:

> Use the more common logging mechanism.
>
> Miscellanea:
>
> o Realign multiline statements
> o Coalesce format
>
> Signed-off-by: Joe Perches <joe@perches.com>
For pxa25x_udc.h:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert

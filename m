From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 3 May 2013 10:33:55 +0800
Subject: [PATCH, RFC 20/22] media: coda: select GENERIC_ALLOCATOR
In-Reply-To: <201305022153.19518.arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-21-git-send-email-arnd@arndb.de>
 <1367515255.447627800@f375.mail.ru>
 <201305022153.19518.arnd@arndb.de>
Message-ID: <20130503023353.GM3442@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 09:53:19PM +0200, Arnd Bergmann wrote:
> Unfortunately, linux-next as of today is still broken. Shawn, did I
> miss a pull request from you?

No, I haven't sent you a pull request for that.  I have queued it for
3.10-rc but am still waiting for a stable base (3.10-rc1 where
coda and genalloc changes should be merged together) to send it out.

Shawn

From: macro@linux-mips.org (Maciej W. Rozycki)
Date: Wed, 27 Jan 2016 15:15:26 +0000 (GMT)
Subject: [PATCH 5/9] net: fddi/defxx: avoid warning about uninitialized
 variable use
In-Reply-To: <1453903507-3427225-6-git-send-email-arnd@arndb.de>
References: <1453903507-3427225-1-git-send-email-arnd@arndb.de>
 <1453903507-3427225-6-git-send-email-arnd@arndb.de>
Message-ID: <alpine.LFD.2.20.1601271513480.7055@eddie.linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jan 2016, Arnd Bergmann wrote:

> This adds code to ensure that the BAR values are initialized
> even in the impossible case when a device gets probed that
> does not belong to any bus. This shuts up the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/fddi/defxx.c | 5 +++++
>  1 file changed, 5 insertions(+)

 NAK, fixed already, commit 62f2aaabcf41 ("defxx: fix build warning").

 Thanks for looking into this problem though, always welcome!

  Maciej

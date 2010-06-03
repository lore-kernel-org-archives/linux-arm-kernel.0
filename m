From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Thu, 03 Jun 2010 09:40:22 +0300 (EEST)
Subject: [PATCH v3 00/14] omap: mailbox: bunch of cleanups
In-Reply-To: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <20100603.094022.200375421.Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 00/14] omap: mailbox: bunch of cleanups
Date: Sat, 22 May 2010 19:14:11 +0200

> Hi,
> 
> These are hopefully non-functional changes. Just shuffling code around, and
> removing unecessary stuff.
> 
> In v2 I tried to split platform_device and also make mailbox_mach built-in. Not
> any more.
> 
> Comments from Felipe Balbi, Tony Lindgren, Hiroshi DOYU, and Russell King.
> 

Have you had a chance to update them?

> Felipe Contreras (14):
>   omap: mailbox: trivial whitespace cleanups
>   omap: mailbox: trivial cleanups
>   omap: mailbox: reorganize structures
>   omap: mailbox: 2420 should be detected at run-time
>   omap: mailbox: use correct config for omap1
>   omap: mailbox: update omap1 probing
>   omap: mailbox: don't export unecessary symbols
>   omap: mailbox: remove unecessary fields
>   omap: mailbox: add IRQ names
>   omap: mailbox: reorganize registering
>   omap: mailbox: only compile for configured archs
>   omap: mailbox: standarize on 'omap-mailbox'
>   omap: mailbox: simplify omap_mbox_register()
>   omap: mailbox: reorganize headers
> 
>  arch/arm/mach-omap1/devices.c             |   11 +-
>  arch/arm/mach-omap1/mailbox.c             |   52 ++++-----
>  arch/arm/mach-omap2/devices.c             |    6 +-
>  arch/arm/mach-omap2/mailbox.c             |  177 +++++++++++++----------------
>  arch/arm/plat-omap/include/plat/mailbox.h |   16 +--
>  arch/arm/plat-omap/mailbox.c              |  136 +++++++++-------------
>  6 files changed, 168 insertions(+), 230 deletions(-)
> 

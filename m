From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Dec 2011 13:59:26 +0000
Subject: [PATCH 3/3] ide/at91: use new introduce smc accessor
In-Reply-To: <1323357784-17555-3-git-send-email-plagnioj@jcrosoft.com>
References: <20111208150348.GD23884@game.jcrosoft.org>
 <1323357784-17555-3-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <201112091359.26439.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 December 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> this will allow to use the pata_at91 on a single zImage
> 
> J.
>  drivers/ide/at91_ide.c |   65 +++++++++++++++++++++++++++--------------------
>  1 files changed, 37 insertions(+), 28 deletions(-)

The description doesn't match the file you are changing. Is there still
a strong reason to keep using the at91_ide driver instead of migrating
everybody to pata_at91 now?

	Arnd

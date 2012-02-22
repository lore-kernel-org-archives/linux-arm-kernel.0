From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Feb 2012 12:31:16 +0000
Subject: [PATCH 4/7] ARM: sa1100: clean up of the clock support
In-Reply-To: <1329815096-6200-5-git-send-email-haojian.zhuang@marvell.com>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
 <1329815096-6200-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <201202221231.16564.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 February 2012, Haojian Zhuang wrote:
> From: Jett.Zhou <jtzhou@marvell.com>
> 
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  arch/arm/Kconfig             |    2 +-
>  arch/arm/mach-sa1100/clock.c |   91 ++++++++++++++++++++++++++++++-----------
>  2 files changed, 67 insertions(+), 26 deletions(-)

I don't see anything wrong with the patch, but you really need to add a
description here, because it's anything but obvious why a "cleanup" would
add three times the lines it removes.

	Arnd

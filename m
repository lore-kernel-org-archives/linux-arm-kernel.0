From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 03 Jun 2016 09:40:40 +0200
Subject: [PATCH v2 0/9] raspberry pi 3 patch series, part 1: essentials
In-Reply-To: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
Message-ID: <4902178.94WeAnbxLk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 3, 2016 8:18:19 AM CEST Gerd Hoffmann wrote:
> Raspberry pi 3 patches, next round.  I'll go split the longish patch
> series into smaller ones.  I'll also go include the linux-arm-kernel
> list this time (note I'm subscribed to linux-rpi-kernel only so please
> take care to keep me in Cc).  This is part one with just the essential
> stuff needed to get the rpi3 boot, without wifi support.
> 
> Changes:
>  * dropped ARCH_BCM kconfig option.
>  * drop include hack for rpi3 device tree in arm.
>  * drop DMA offset patch, pick up the version from Alex instead.
> 
> Patches are also available from:
>   git://git.kraxel.org/linux bcm2837-47-v2
> 
> Note that the git branch has the complete set of patches (including
> device tree patches and rpi3 wifi).

Looks good overall, thanks for sending the more manageable series.

See individual replies for a couple of comments on details.

	Arnd

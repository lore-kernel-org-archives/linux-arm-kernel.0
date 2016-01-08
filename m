From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 11:52:07 +0100
Subject: [PATCH 1/2] arm: multi_v7_defconfig: Add virtio drivers
In-Reply-To: <2934460.yQH6ldG89f@wuerfel>
References: <1451919034-12846-1-git-send-email-andre.przywara@arm.com>
 <1451919034-12846-2-git-send-email-andre.przywara@arm.com>
 <2934460.yQH6ldG89f@wuerfel>
Message-ID: <5500907.UY3akVGP20@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 January 2016 16:11:12 Arnd Bergmann wrote:
> On Monday 04 January 2016 14:50:33 Andre Przywara wrote:
> > To make multi_v7_defconfig really "multi", let's add virtio drivers
> > to allow booting a default kernel as a KVM/QEMU guest.
> > MACH_VIRT is already defined, so we just add VIRTIO_BLK, VIRTIO_NET
> > and VIRTIO_CONSOLE to actually make this kernel useful in a guest.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > 
> 
> This one looks good.
> 

I've applied it to next/defconfig now, with a trivial conflict resolved.
Thanks,

	Arnd

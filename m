From: arnab.basu@freescale.com (Arnab Basu)
Date: Wed, 6 Aug 2014 00:16:47 +0530
Subject: Regarding CONFIG_BLK_DEV_RAM and CONFIG_BLK_DEV_RAM_SIZE in
 arch/arm64/configs/defconfig
In-Reply-To: <20140805134053.GJ18780@arm.com>
References: <53E0DB92.2030609@freescale.com> <20140805134053.GJ18780@arm.com>
Message-ID: <53E12697.9090807@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2014 07:10 PM, Will Deacon wrote:
> On Tue, Aug 05, 2014 at 02:26:42PM +0100, Arnab Basu wrote:
>> Hi
>
> Hi Arnab,
>
>> While trying to boot Linux with an initrd I found that
>> CONFIG_BLK_DEV_RAM and CONFIG_BLK_DEV_RAM_SIZE are not part of the arm64
>> defconfig. Is this because no one has got around to adding them or is
>> this something that has been omitted on purpose?
>
> Do we really want CONFIG_BLK_DEV_RAM=y by default? The Kconfig text for the
> options says:
>
> 	Most normal users won't need the RAM disk functionality, and can
> 	thus say N here.
>
> so I'd be inclined to say we should leave things as they are. The current
> defconfig is largely driven by our testing efforts, but I've been enabling
> other options that could benefit many people without hindering others (e.g.
> DEVTMPFS_MOUNT).
>

Thanks for explaining Will.

Arnab

> Will
>

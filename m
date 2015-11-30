From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Nov 2015 22:41:46 +0100
Subject: [PATCH] mtd: cfi: don't warn about broken geometry for !CONFIG_MTD
In-Reply-To: <20151130205505.GN64635@google.com>
References: <3747078.dk5V5gxuXa@wuerfel> <7025557.qur2fOT79A@wuerfel>
 <20151130205505.GN64635@google.com>
Message-ID: <14806491.ddHvmkgsQi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 November 2015 12:55:05 Brian Norris wrote:
> 
> I guess no one includes mtd/cfi.h with CONFIG_MTD=n? Otherwise, we might
> have the same problems there.

Right, I checked that all users of that file depend on CONFIG_MTD.

> Pushed to l2-mtd.git, thanks!

Thanks,

	ARnd

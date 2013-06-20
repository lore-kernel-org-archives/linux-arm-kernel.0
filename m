From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 22:14:51 +0200
Subject: Get machine type in user space
In-Reply-To: <20130620194512.GA7269@kahuna>
References: <CABp-a4cUbwXEGPUQBjGRnNR+X91j1qGQigS=KYTZ1fZ2ZGzQtA@mail.gmail.com>
 <201306202130.55247.arnd@arndb.de> <20130620194512.GA7269@kahuna>
Message-ID: <201306202214.51444.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 June 2013, Nishanth Menon wrote:
> Documentation/ABI/testing/sysfs-devices-soc exposes
> /sys/devices/socX/machine if enabled might help as well?

In theory yes, but in practice very few platforms provide this,
so you cannot rely on it being present.

	Arnd

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jan 2010 12:19:51 +0000
Subject: [PATCH] arch/arm/common/vic.c: code reorganization
In-Reply-To: <63386a3d1001120034g485eb059uf916119dcf4c42ed@mail.gmail.com>
References: <20090918163111.GA2284@n2100.arm.linux.org.uk>
	<BD79186B4FD85F4B8E60E381CAEE190901D42615@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7709@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7D84@mi8nycmail19.Mi8.com>
	<63386a3d0910120202u5144bc7ep6b2008a71089369e@mail.gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7EFD@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE19090200F124@mi8nycmail19.Mi8.com>
	<63386a3d1001071415r5a832252lf16b19c3261f2c62@mail.gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE1909020895EA@mi8nycmail19.Mi8.com>
	<63386a3d1001120034g485eb059uf916119dcf4c42ed@mail.gmail.com>
Message-ID: <20100112121951.GD27771@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 09:34:41AM +0100, Linus Walleij wrote:
> 2010/1/7 H Hartley Sweeten <hartleys@visionengravers.com>:
> 
> > [ARM] vic.c: reorganize code
> > This reorganizes the vic.c code in anticipation of a second patch
> > to use struct vic_device as the data stored in set_irq_chip_data().
> 
> Works like a charm on the U300!
> Tested-by: Linus Walleij <linus.walleij@stericsson.com>

Great, I guess the patch is ready.

From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 7 Jan 2010 23:15:37 +0100
Subject: [PATCH] arch/arm/common/vic.c: code reorganization
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090200F124@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF46D@mi8nycmail19.Mi8.com>
	<63386a3d0909180155s3032d6e7jc18b36e1b62a288f@mail.gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D41EF4@mi8nycmail19.Mi8.com>
	<20090918163111.GA2284@n2100.arm.linux.org.uk>
	<BD79186B4FD85F4B8E60E381CAEE190901D42615@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7709@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7D84@mi8nycmail19.Mi8.com>
	<63386a3d0910120202u5144bc7ep6b2008a71089369e@mail.gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7EFD@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE19090200F124@mi8nycmail19.Mi8.com>
Message-ID: <63386a3d1001071415r5a832252lf16b19c3261f2c62@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/12/21 H Hartley Sweeten <hartleys@visionengravers.com>:

> [ARM] vic.c: reorganize code
> This reorganizes the vic.c code in anticipation of a second patch
> to use struct vic_device as the data stored in set_irq_chip_data().

I would love to test this patch but again cannot *for my life* decode this QP
stuff, having tried now for half an hour. Can you send it directly as an
attachment instead or even put it in Russells patch tracker?

Linus

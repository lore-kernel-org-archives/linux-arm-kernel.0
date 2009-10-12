From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 12 Oct 2009 11:02:16 +0200
Subject: [PATCH] arch/arm/common/vic.c: code reorganization
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901DB7D84@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF46D@mi8nycmail19.Mi8.com>
	<63386a3d0909180155s3032d6e7jc18b36e1b62a288f@mail.gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D41EF4@mi8nycmail19.Mi8.com>
	<20090918163111.GA2284@n2100.arm.linux.org.uk>
	<BD79186B4FD85F4B8E60E381CAEE190901D42615@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7709@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7D84@mi8nycmail19.Mi8.com>
Message-ID: <63386a3d0910120202u5144bc7ep6b2008a71089369e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/10/9 H Hartley Sweeten <hartleys@visionengravers.com>:

> This reorganizes the vic.c code in anticipation of a future patch
> to use struct vic_device as the data stored in set_irq_chip_data().

I've tried to test this but I've got some real mangling problems when I
bring up the raw mail, =20 =3D and =<newline> all over the place,
I don't know if this is all my own fault, so that gmail mangles it.
Can you send me a copy as an attachment that I can test?

Linus Walleij

From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Wed, 13 Jan 2010 13:58:57 +0100
Subject: [PATCH] arch/arm/common/vic.c: code reorganization
In-Reply-To: <20100112121951.GD27771@n2100.arm.linux.org.uk>
References: <20100112121951.GD27771@n2100.arm.linux.org.uk>
	<20090918163111.GA2284@n2100.arm.linux.org.uk>
	<BD79186B4FD85F4B8E60E381CAEE190901D42615@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7709@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7D84@mi8nycmail19.Mi8.com>
	<63386a3d0910120202u5144bc7ep6b2008a71089369e@mail.gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7EFD@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE19090200F124@mi8nycmail19.Mi8.com>
	<63386a3d1001071415r5a832252lf16b19c3261f2c62@mail.gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE1909020895EA@mi8nycmail19.Mi8.com>
	<63386a3d1001120034g485eb059uf916119dcf4c42ed@mail.gmail.com>
Message-ID: <20100113125856.GA30864@morgana.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fine on Nomadik too (the only one that uses 64 irqs in the vic, I suppose).
But I confirm the orignal mail doesn't apply. I used the one attached
as a non-git patch.

>> Tested-by: Linus Walleij <linus.walleij@stericsson.com>

Tested-by: Alessandro Rubini <rubini@unipv.it>

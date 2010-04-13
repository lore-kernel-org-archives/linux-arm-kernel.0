From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 13 Apr 2010 02:26:36 +0200
Subject: [PATCH] Arm nomadik : Vendor tool compatibility
In-Reply-To: <y2l8cad0aa1004121229o894a17f0w9045882c214bd090@mail.gmail.com>
References: <577FAEEB8540FB4F9C91B6BB262576755905DC@XVS-DCFR-22.europe.corp.altran.com>
	<x2y63386a3d1003311634l71486234n95f60e506b776948@mail.gmail.com>
	<y2l8cad0aa1004121229o894a17f0w9045882c214bd090@mail.gmail.com>
Message-ID: <t2m63386a3d1004121726nb6afdad1q2d75ebba34caefa3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/4/12 Jean-Michel Hautbois <jhautbois@gmail.com>:

> What king of modification would you do ?

Instead of coding the ECC layout into the driver I would move it to the
machine config in arch/arm/mach-* and pass it in as platform data
to the driver.

> Do you think it shall be queued before your submission ?

I will fix it for all users the day I have time, please queue this
as it is now.

Yours,
Linus Walleij

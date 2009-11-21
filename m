From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 21 Nov 2009 18:27:54 +0100
Subject: [PATCH 07/10] ARM: PNX4008: move i2c suspend/resume callbacks
	into driver
In-Reply-To: <E1NBUkU-0004Pm-Nv@rmk-PC.arm.linux.org.uk>
References: <20091120144422.GA18223@n2100.arm.linux.org.uk>
	<E1NBUkU-0004Pm-Nv@rmk-PC.arm.linux.org.uk>
Message-ID: <63386a3d0911210927u47c7d6d6i65fc7d60563f8db2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If you have this up for testing anyway, would it be advisable to take this
opportunity to also switch i2c-pnx over to using struct dev_pm_ops?

i2c-pxa, i2c-s3c2410 and i2c-sh_mobile are already using the new
PM primitives.

Yours,
Linus Walleij

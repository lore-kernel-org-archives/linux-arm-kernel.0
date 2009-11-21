From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Nov 2009 18:59:47 +0000
Subject: [PATCH 07/10] ARM: PNX4008: move i2c suspend/resume callbacks
	into driver
In-Reply-To: <63386a3d0911210927u47c7d6d6i65fc7d60563f8db2@mail.gmail.com>
References: <20091120144422.GA18223@n2100.arm.linux.org.uk>
	<E1NBUkU-0004Pm-Nv@rmk-PC.arm.linux.org.uk>
	<63386a3d0911210927u47c7d6d6i65fc7d60563f8db2@mail.gmail.com>
Message-ID: <20091121185947.GD13956@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2009 at 06:27:54PM +0100, Linus Walleij wrote:
> If you have this up for testing anyway, would it be advisable to take this
> opportunity to also switch i2c-pnx over to using struct dev_pm_ops?

These patches are only compile-tested, and that's partly why there's soo
many of them - each one does one transformation, which makes it easy to
review for correctness.

I'm also hoping that Kevin will test them on later PNX hardware so that
they can be submitted.

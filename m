From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Thu, 20 Feb 2014 00:03:10 +0100
Subject: I2C dummy adapter driver ?
Message-ID: <5305382E.9050902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I was wondering whether it would be reasonable to create a generic
Linux dummy I2C bus controller driver. The rationale behind it is
there might be hardware configurations where I2C communication is
handled by firmware but still it is useful to have I2C slave devices
instantiated by a Linux I2C bus adapter driver.
It would be useful to have the common devicetree I2C binding scheme
working regardless of where the I2C communication is handled - in
firmware or by the host CPU.

Currently we have a somewhat dummy I2C adapter driver at drivers/media/
platform/exynos4-is/fimc-is-i2c.c. But it is going to be needed by
multiple SoCs and I thought about separating it or creating a generic
dummy I2C adapter driver.

Thoughts, suggestions ?

Thanks,
Sylwester

From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 Dec 2009 12:16:43 +0000
Subject: [PATCH 3/5] SPI S3C64XX: Header for passing platform data
In-Reply-To: <1b68c6790912081750r7a68f019w39a5170c9796e7b9@mail.gmail.com>
References: <1259218097-9845-1-git-send-email-jassi.brar@samsung.com>
	<20091203220637.GR4808@trinity.fluff.org>
	<1b68c6790912040306m3098cba9wf67bfe5bfefb7e23@mail.gmail.com>
	<20091207144145.GT4808@trinity.fluff.org>
	<1b68c6790912081750r7a68f019w39a5170c9796e7b9@mail.gmail.com>
Message-ID: <20091209121643.GD9018@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2009 at 10:50:16AM +0900, jassi brar wrote:

>   Second - SPI source clocks specific, which SoCs differ by name and number.
>           Maybe this could go into plat-<soc>/include with the name
>           <soc>-spi.h

With device based lookup (which Ben mentioned he was working on) this
mapping should get handled entirely within the CPU clock tree
definition and be invisible to the driver.

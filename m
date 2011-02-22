From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Feb 2011 13:05:36 -0800
Subject: [PATCH 6/6] ARM: tegra: add seaboard, wario and kaen boards
In-Reply-To: <20110222204821.GE29559@n2100.arm.linux.org.uk>
References: <1298354117-19097-1-git-send-email-olof@lixom.net>
	<1298354117-19097-7-git-send-email-olof@lixom.net>
	<20110222204821.GE29559@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimymMLPswnALDuePEdabXGaH7MgOQafx-juLEto@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22, 2011 at 12:48 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:


>> +#include <mach/gpio.h>
>
> Another linux/gpio.h please.

Another d'oh. Thanks.

mach/io.h and mach/gpio.h seem to be common mistakes in general. I'll
look at adding it to checkpatch while I'm still annoyed at having made
the mistakes. :)


-olof

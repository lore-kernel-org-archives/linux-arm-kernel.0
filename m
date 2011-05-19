From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 May 2011 09:19:44 +0200
Subject: [PATCH 01/19] Make clocksource name const
In-Reply-To: <E1QM1YI-0003DJ-BQ@rmk-PC.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1YI-0003DJ-BQ@rmk-PC.arm.linux.org.uk>
Message-ID: <BANLkTin-N-=CcS0nDrNH1wmSWHtxg8gMVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/16 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> As nothing should be writing to the clocksource name string, make the
> clocksource name pointer const. ?Build-tested on ARM Versatile Express.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

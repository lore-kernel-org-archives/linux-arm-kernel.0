From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Jan 2013 20:37:53 +0000
Subject: [PATCH V2 0/4] add RTC support for Armada 370 and Armada XP
In-Reply-To: <1355303186-9267-1-git-send-email-gregory.clement@free-electrons.com>
References: <1355303186-9267-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201301092037.53751.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 December 2012, Gregory CLEMENT wrote:
> This small patch set adds RTC support for Armada 370 and Armada XP. It
> was successfully tested on the evaluation board. The third patch add
> the lacking documentation for the device tree binding and was already
> taken by Grant Likely, I keep this one in the series for
> coherency. The only differences with the previous patch set was the
> add of the Acked-by from Andrew Lunn and a new small patch to update
> of the mvebu_configuration. I also split the patch wich add the RTC
> support in two part, one for the RTC subsytem and on for
> mach-mvebu. This series is 3.9 material.

Nice and small!

Acked-by: Arnd Bergmann <arnd@arndb.de>

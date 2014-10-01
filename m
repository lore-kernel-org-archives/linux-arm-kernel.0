From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Oct 2014 18:11:19 +0200
Subject: [GIT PULL] Add initial support for Broadcom Cygnus SoC
In-Reply-To: <1411691389-22140-1-git-send-email-f.fainelli@gmail.com>
References: <1411691389-22140-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <201410011811.19199.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 September 2014, Florian Fainelli wrote:
> This patchset contains initial support for Broadcom's Cygnus SoC based on our
> iProc architecture. Initial support is minimal and includes just the mach
> platform code, clock driver, and a basic device tree configuration. Peripheral
> drivers will be submitted soon, as will device tree configurations for other
> Cygnus board variants.

I think this hasn't seen enough review and is too late for 3.18, so not pulled.

Please submit the patches again after the merge window.

The clock driver should get merged by the clk maintainer. We can make exceptions
for merging drivers through arm-soc, but not without an explict request from
the respective maintainer.

I'll have lots of comments about the platform code too, but don't have time
at the moment to do a thorough review.

	Arnd

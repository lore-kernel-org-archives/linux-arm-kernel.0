From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 12:02:41 +0100
Subject: [GIT PULL 2/3] omap gpmc changes for v3.19
In-Reply-To: <pull-1415814409-868361-2>
References: <pull-1415814409-868361> <pull-1415814409-868361-2>
Message-ID: <201411201202.41698.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 November 2014, Tony Lindgren wrote:
> GPMC (General Purpose Memory Controller) changes for omaps. These
> changes allow us to drop dependencies to bootloader timings now
> that the known device tree entries have been fixed. So we can now
> require proper timings to be configured and get rid of the legacy
> smsc91x code.
> 
> Note that this branch has a dependency to the related device tree
> branch sent in a separate pull request as timings are now required.

Does this mean you are breaking compatibility with old dtb files?

Can you be more specific which machines are affected?

	Arnd

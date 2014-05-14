From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 May 2014 20:56:24 +0200
Subject: [PATCH v3 0/6] Add platform support for LSI AXM55xx
In-Reply-To: <cover.1400072260.git.anders.berg@avagotech.com>
References: <cover.1400072260.git.anders.berg@avagotech.com>
Message-ID: <6334605.NlytHCzYVP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 May 2014 20:37:55 Anders Berg wrote:
> 
> This is version 3 of this series to introduces basic platform support for the LSI
> AXM5516 SoC.
> 
> No major changes since v2. Ready to be applied to the arm-soc tree?

I think it's good, but I'm not sure if we should put them all into arm-soc.
There are no dependencies between the drivers that I can see, so why not
merge the clock and reset drivers through the individual subsystem maintainers?

We can take patches 1/3/4/6, and the others if there is a good reason
not to have the regular maintainers pick them up.

The hip04 platform series is also adding a multi_v7_lpae_defconfig file.
it would be good to add axxia to that config and also to the regular
multi_v7_defconfig, but that can be an add-on patch once we have merged
hip04.

	Arnd

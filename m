From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Feb 2014 17:22:59 +0100
Subject: [GIT PULL] kconfig clean-up and mach-virt removal for 3.15
In-Reply-To: <CAL_Jsq+vd6XAgj6FawKX4p8Yx0R308mxMxVfzgtNgcBTecx-kg@mail.gmail.com>
References: <CAL_Jsq+vd6XAgj6FawKX4p8Yx0R308mxMxVfzgtNgcBTecx-kg@mail.gmail.com>
Message-ID: <201402281723.00308.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 February 2014, Rob Herring wrote:
-------------------------------------------
> - Remove common kconfig options required by multi-platform builds out
> of individual platforms as they are redundant.
> - Make SMP, CACHE_L2X0 and GPIO config options user visible on
> multi-platform builds as most platforms enable these options and all
> platforms can run with them enabled.
> - Make multi-platform v6 default to more optimal v6k rather than v6
> - Remove the last bit of mach-virt and convert it to just a kconfig
> option.

Merged into next/cleanup. Very much appreciated changes!

Thanks,

	Arnd

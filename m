From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 23 Aug 2013 11:31:04 -0700
Subject: [GIT PULL] ARM: OMAP: Device Tree for 3.12
In-Reply-To: <5214D4FD.4060405@baylibre.com> (Benoit Cousson's message of
 "Wed, 21 Aug 2013 16:55:57 +0200")
References: <521384D5.1050607@baylibre.com>
 <20130821071334.GQ7656@atomide.com> <5214D4FD.4060405@baylibre.com>
Message-ID: <87fvu0mf87.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit Cousson <bcousson@baylibre.com> writes:

> Hi Kevin & Olof,
>
> I've just updated the branch with the few USB3 patches I missed from Felipe.
>
> So here is a new pull-request.
>
> Thanks,
> Benoit
>
> ----------------------------------------------------------------
> Add the minimal DTS support for DRA7xx based SoC core.
> Add the initial support for N900 and gta04 phones.
> Enable USB3 on OMAP5 evm board.
> Do a lot of various cleanups.
> ----------------------------------------------------------------

This is a nice description, but would be even better if it was the
description of the signed tag.  For future pulls, since we're pulling
from you directly into arm-soc, can you start using signed tags please?


> The following changes since commit b36f4be3de1b123d8601de062e7dbfc904f305fb:
>
>   Linux 3.11-rc6 (2013-08-18 14:36:53 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.12/dts
>
> for you to fetch changes up to 5903208d4e2c09a3872feba6b9e2e49c64fd07ad:
>
>   ARM: configs: omap2plus_defconfig: enable dwc3 and dependencies (2013-08-21 16:43:21 +0200)
>

Pulled into next/dt.

Benoit, since we're pulling directly from you into arm-soc, can you
start using signed tags please?  Thanks.

Kevin

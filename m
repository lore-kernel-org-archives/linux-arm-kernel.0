From: ckeepax@opensource.cirrus.com (Charles Keepax)
Date: Fri, 29 Dec 2017 10:52:12 +0000
Subject: [PATCH 3/5] ARM: S3C64XX: Add SPDX license identifier
In-Reply-To: <1514231675-17582-3-git-send-email-krzk@kernel.org>
References: <1514231675-17582-1-git-send-email-krzk@kernel.org>
 <1514231675-17582-3-git-send-email-krzk@kernel.org>
Message-ID: <20171229105212.thkj4q4qezsg2jdl@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 25, 2017 at 08:54:33PM +0100, Krzysztof Kozlowski wrote:
> Replace GPL license statements with a SPDX license indentifiers (GPL-2.0
> and GPL-2.0+).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/mach-s3c64xx/crag6410.h                  |  5 +----
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c      | 15 ++++++-------
>  arch/arm/mach-s3c64xx/mach-crag6410.c             | 19 ++++++-----------

For the Cragganmore bits:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> index ea5f2169c850..29ed7b7bafb6 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> @@ -1,12 +1,9 @@
> -/* Speyside modules for Cragganmore - board data probing
> - *
> - * Copyright 2011 Wolfson Microelectronics plc
> - *	Mark Brown <broonie@opensource.wolfsonmicro.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +//Speyside modules for Cragganmore - board data probing

There is a space missing here but probably only worth fixing if
you are respinning the series for other reasons anyway.

> +//
> +// Copyright 2011 Wolfson Microelectronics plc
> +//	Mark Brown <broonie@opensource.wolfsonmicro.com>

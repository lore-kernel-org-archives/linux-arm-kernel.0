From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 18:56:21 -0700
Subject: [GIT PULL 1/2] omap gpmc changes for v4.13
In-Reply-To: <5937f0c8.4debca0a.53849.e49dSMTPIN_ADDED_BROKEN@mx.google.com>
References: <5937f0c8.4debca0a.53849.e49dSMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20170619015621.GC30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 05:25:24AM -0700, Tony Lindgren wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.13/gpmc-signed
> 
> for you to fetch changes up to c9eabf40d91b4fe954efe380d88590d933baa06d:
> 
>   memory: omap-gpmc: add error message if bank-width property is absent (2017-05-31 10:08:10 -0700)
> 
> ----------------------------------------------------------------
> Few improvments for GPMC (General Purpose Memory Controller)
> found on TI SoCs to produce an error for missing bank-width
> and to make the bootloader timing debug output usable for
> device tree timings.

Thanks, merged into next/drivers.


-Olof

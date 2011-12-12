From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 12 Dec 2011 18:44:29 +0100
Subject: [PATCH 1/2] ARM: sa11x0: Implement autoloading of codec and
 codec pdata for mcp bus.
In-Reply-To: <1322427655-914-1-git-send-email-jochen@scram.de>
References: <1322427655-914-1-git-send-email-jochen@scram.de>
Message-ID: <20111212174429.GU13952@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jochen,

On Sun, Nov 27, 2011 at 10:00:54PM +0100, Jochen Friedrich wrote:
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
>  arch/arm/mach-sa1100/assabet.c          |    1 +
>  arch/arm/mach-sa1100/cerf.c             |    1 +
>  arch/arm/mach-sa1100/collie.c           |    8 ++++-
>  arch/arm/mach-sa1100/include/mach/mcp.h |    2 +
>  arch/arm/mach-sa1100/lart.c             |    1 +
>  arch/arm/mach-sa1100/shannon.c          |    1 +
>  arch/arm/mach-sa1100/simpad.c           |    8 ++++-
>  drivers/mfd/mcp-core.c                  |   44 +++++++++++++++++++++++++++-
>  drivers/mfd/mcp-sa11x0.c                |    7 +++-
>  drivers/mfd/ucb1x00-core.c              |   48 +++++++++++++++++++++++-------
>  drivers/mfd/ucb1x00-ts.c                |    2 +-
>  include/linux/mfd/mcp.h                 |    7 +++-
>  include/linux/mfd/ucb1x00.h             |    5 ++-
>  include/linux/mod_devicetable.h         |   11 +++++++
>  scripts/mod/file2alias.c                |   13 ++++++++
>  15 files changed, 138 insertions(+), 21 deletions(-)
I applied your 2 patches, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

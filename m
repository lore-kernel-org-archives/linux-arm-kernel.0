From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 01 Dec 2011 19:29:49 +0900
Subject: [PATCH 0/7] Cragganmore updates for 3.3
In-Reply-To: <20111129133006.GA26800@opensource.wolfsonmicro.com>
References: <20111129133006.GA26800@opensource.wolfsonmicro.com>
Message-ID: <047301ccb014$273745b0$75a5d110$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> This patch series is all the pending updates for Cragganmore for 3.3.
> With the exception of the final patch for Littlemill they've all been
> posted before, some a while ago now, but I've not seen any feedback yet.
> They're all available on a git branch in case it's helpful to pull them:
> 
> The following changes since commit
> caca6a03d365883564885f2c1da3e88dcf65d139:
> 
>   Linux 3.2-rc3 (2011-11-23 20:20:28 -0800)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
> updates/cragganmore
> 
> Mark Brown (7):
>       ARM: S3C64XX: Raise the frequency of the second I2C bus on
> Cragganmore
>       ARM: S3C64XX: Use software initiated powerdown for Cragganmore
>       ARM: S3C64XX: Configure WM1250 EV1 GPIOs on Cragganmore
>       ARM: S3C64XX: Improve logging of unknown Cragganmore module types
>       ARM: S3C64XX: Run Tobermory interrupts in the default mode
>       ARM: S3C64XX: Hook up platform data for Kilchomin module on
> Cragganmore
>       ARM: S3C64XX: Hook up Littlemill audio card on Cragganmore
> 
>  arch/arm/mach-s3c64xx/include/mach/crag6410.h |    6 ++-
>  arch/arm/mach-s3c64xx/include/mach/irqs.h     |    2 +-
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c  |   56
> +++++++++++++++++++++++-
>  arch/arm/mach-s3c64xx/mach-crag6410.c         |   30 ++++++++++++-
>  4 files changed, 86 insertions(+), 8 deletions(-)

Looks ok, will apply this series.

And as a note, I'm thinking about the handling of different
IRQ_BOARD_NR...but I'm not sure it is really needed or not :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

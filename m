From: carlo@caione.org (Carlo Caione)
Date: Wed, 21 May 2014 09:24:43 +0200
Subject: [PATCH v6 0/7] mfd: AXP20x: Add support for AXP202 and AXP209
In-Reply-To: <20140520222307.GK12304@sirena.org.uk>
References: <1400528868-5971-1-git-send-email-carlo@caione.org>
 <20140520222307.GK12304@sirena.org.uk>
Message-ID: <CAOQ7t2aBc5tFYk2MkfL9QqvFf5fcebwKtO97F3S=WdJ2uFE_jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 12:23 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, May 19, 2014 at 09:47:41PM +0200, Carlo Caione wrote:
>
>> This set of patches introduces the core driver and support for two different
>> subsystems:
>>       - Regulators
>
>>  .../ABI/testing/sysfs-driver-input-axp-pek         |  11 +
>>  Documentation/devicetree/bindings/mfd/axp20x.txt   |  93 +++++++
>>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>>  arch/arm/configs/multi_v7_defconfig                |   3 +
>>  arch/arm/configs/sunxi_defconfig                   |   4 +
>>  drivers/input/misc/Kconfig                         |  11 +
>>  drivers/input/misc/Makefile                        |   1 +
>>  drivers/input/misc/axp20x-pek.c                    | 281 +++++++++++++++++++++
>>  drivers/mfd/Kconfig                                |  12 +
>>  drivers/mfd/Makefile                               |   1 +
>>  drivers/mfd/axp20x.c                               | 258 +++++++++++++++++++
>>  include/linux/mfd/axp20x.h                         | 180 +++++++++++++
>>  12 files changed, 856 insertions(+)
>
> The regulator changes don't appear to be showing up in the diffstat or
> obviously in the series?

Right. Cut-and-paste error.
You have already applied the regulator patches so I didn't include
them here (in theory I posted this series to be picked up by Lee).

Thanks,

-- 
Carlo Caione

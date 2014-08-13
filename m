From: lkurusa@redhat.com (Levente Kurusa)
Date: Wed, 13 Aug 2014 14:36:26 +0200
Subject: [PATCH] dma: xilinx: Remove .owner field for driver
In-Reply-To: <f82330042cf6185a1f4e18232ebf6999662ae48f.1407931050.git.michal.simek@xilinx.com>
References: <f82330042cf6185a1f4e18232ebf6999662ae48f.1407931050.git.michal.simek@xilinx.com>
Message-ID: <CAAsK9AGD7x710OwxKxqf4CSEeiE3zmC5M3YDrDL9Bu0hpwPPqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-08-13 13:57 GMT+02:00 Michal Simek <michal.simek@xilinx.com>:
> There is no need to init .owner field.
>
> Based on the patch from Peter Griffin <peter.griffin@linaro.org>
> "mmc: remove .owner field for drivers using module_platform_driver"
>
> This patch removes the superflous .owner field for drivers which
> use the module_platform_driver API, as this is overriden in
> platform_driver_register anyway."
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Levente Kurusa <lkurusa@redhat.com>

Cheers,
Levente Kurusa

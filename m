From: joe@perches.com (Joe Perches)
Date: Fri, 29 May 2015 22:29:30 -0700
Subject: [PATCH 0/4] Cover: Support mbigen msi interrupt controller
In-Reply-To: <55692C24.107@huawei.com>
References: <55692C24.107@huawei.com>
Message-ID: <1432963770.2984.4.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-05-30 at 11:19 +0800, majun (F) wrote:
> This patch set is applied to supprot the mbigen device.
[]
>  create mode 100755 Documentation/devicetree/bindings/arm/mbigen.txt
>  mode change 100644 => 100755 drivers/irqchip/Kconfig
>  mode change 100644 => 100755 drivers/irqchip/Makefile
>  mode change 100644 => 100755 drivers/irqchip/irq-gic-v3-its.c
>  create mode 100755 drivers/irqchip/irq-mbigen.c
>  create mode 100755 include/linux/irqchip/arm-gic-its.h
>  create mode 100644 include/linux/mbi.h
>  mode change 100644 => 100755 include/linux/msi.h
>  mode change 100644 => 100755 kernel/irq/msi.c

None of these should be executable

All of them should be 644

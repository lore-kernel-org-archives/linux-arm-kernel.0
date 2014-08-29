From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Aug 2014 07:46:45 +0200
Subject: [PATCH] gpio: zynq: Remove .owner field for driver
In-Reply-To: <78682b5ace6f31f2b52496823823116076eefd61.1407931277.git.michal.simek@xilinx.com>
References: <78682b5ace6f31f2b52496823823116076eefd61.1407931277.git.michal.simek@xilinx.com>
Message-ID: <CACRpkdYBbonERHWMWF3X5VfwWaiwc7OfwadyR0Nbr=x0NixBMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 2:01 PM, Michal Simek <michal.simek@xilinx.com> wrote:

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

Patch applied.

Yours,
Linus Walleij

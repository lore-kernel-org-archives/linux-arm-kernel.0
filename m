From: robh@kernel.org (Rob Herring)
Date: Tue, 27 Nov 2018 10:57:32 -0600
Subject: [PATCH] irqchhip: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20181123165418.27745-1-tiny.windzz@gmail.com>
References: <20181123165418.27745-1-tiny.windzz@gmail.com>
Message-ID: <CAL_JsqL7T4=c_NBdSaBD-ecS7vY2FUe8k23ipeff8oyxq=9tew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:54 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/irqchip/irq-mscc-ocelot.c |  6 +++---
>  drivers/irqchip/irq-stm32-exti.c  |  6 +++---
>  drivers/irqchip/irq-tango.c       | 10 +++++-----
>  3 files changed, 11 insertions(+), 11 deletions(-)

Same here. Already queued a patch for these and others missed here.

Rob
